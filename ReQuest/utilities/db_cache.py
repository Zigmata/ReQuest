import json
import logging

from ReQuest.utilities.constants import CommonFields
from ReQuest.utilities.exceptions import log_exception

logger = logging.getLogger(__name__)

__all__ = ['build_cache_key', 'get_cached_data', 'update_cached_data', 'replace_cached_data', 'delete_cached_data']


def build_cache_key(database_name, identifier, collection_name):
    return f'{database_name}:{identifier}:{collection_name}'


async def get_cached_data(bot, mongo_database, collection_name, query, is_single=True, cache_id=None):
    """
    Fetches a document from mongodb using redis caching.

    :param bot: the discord bot instance
    :param mongo_database: the mongodb database instance
    :param collection_name: the mongodb collection name
    :param query: mongodb dict query
    :param is_single: whether to fetch a single document or return a list of documents
    :param cache_id: optional identifier for redis caching; if not provided, uses the '_id' from the query

    :return: the fetched document(s) or None if not found
    """
    if cache_id is None:
        if CommonFields.ID in query:
            cache_id = query[CommonFields.ID]
        else:
            raise ValueError('cache_id must be provided if "_id" is not in the query.')

    cache_key = build_cache_key(mongo_database.name, cache_id, collection_name)

    try:
        cached = await bot.rdb.get(cache_key)
        if cached:
            return json.loads(cached)
    except Exception as e:
        logger.error(f"Redis read failed: {e}")
        await log_exception(e)

    try:
        if is_single:
            data = await mongo_database[collection_name].find_one(query)

            if data:
                try:
                    await bot.rdb.set(cache_key, json.dumps(data, default=str), ex=3600)
                except Exception as e:
                    logger.error(f"Redis write failed: {e}")
        else:
            cursor = mongo_database[collection_name].find(query)
            data = await cursor.to_list(length=None)

            if data:
                try:
                    await bot.rdb.set(cache_key, json.dumps(data, default=str), ex=3600)
                except Exception as e:
                    logger.error(f"Redis write failed: {e}")

        return data
    except Exception as e:
        await log_exception(e)
        return None


async def update_cached_data(bot, mongo_database, collection_name, query, update_data,
                             is_single: bool = True, cache_id=None):
    """
    Updates mongodb and deletes the corresponding key from redis

    :param bot: the discord bot instance
    :param mongo_database: the mongodb database instance
    :param collection_name: the mongodb collection name
    :param query: mongodb dict query
    :param update_data: the update dict for mongo
    :param is_single: whether to update a single document or multiple
    :param cache_id: identifier for redis; if not provided, uses the '_id' from the query
    """
    if cache_id is None:
        if CommonFields.ID in query:
            cache_id = query[CommonFields.ID]
        else:
            raise ValueError('cache_id must be provided if "_id" is not in the query.')

    cache_key = build_cache_key(mongo_database.name, cache_id, collection_name)

    try:
        mongo_collection = mongo_database[collection_name]
        if is_single:
            await mongo_collection.update_one(
                query,
                update_data,
                upsert=True
            )
        else:
            await mongo_collection.update_many(
                query,
                update_data,
                upsert=True
            )
    except Exception as e:
        raise Exception(f'Error updating config in database: {e}') from e

    try:
        await bot.rdb.delete(cache_key)
    except Exception as e:
        logger.error(f"Redis delete failed: {e}")


async def replace_cached_data(bot, mongo_database, collection_name, query, new_data, cache_id=None):
    """
    Replaces a document in mongodb and deletes the corresponding key from redis

    :param bot: the discord bot instance
    :param mongo_database: the mongodb database instance
    :param collection_name: the mongodb collection name
    :param query: mongodb dict query
    :param new_data: the new document data to replace with
    :param cache_id: identifier for redis; if not provided, uses the '_id' from the query
    """
    if cache_id is None:
        if CommonFields.ID in query:
            cache_id = query[CommonFields.ID]
        else:
            raise ValueError('cache_id must be provided if "_id" is not in the query.')

    cache_key = build_cache_key(mongo_database.name, cache_id, collection_name)

    try:
        mongo_collection = mongo_database[collection_name]
        await mongo_collection.replace_one(
            query,
            new_data,
            upsert=True
        )
    except Exception as e:
        raise Exception(f'Error replacing config in database: {e}') from e

    try:
        await bot.rdb.delete(cache_key)
    except Exception as e:
        logger.error(f"Redis delete failed: {e}")


async def delete_cached_data(bot, mongo_database, collection_name, search_filter,
                             is_single: bool = True, cache_id=None):
    """
    Deletes documents from mongodb and deletes the corresponding keys from redis

    :param bot: the discord bot instance
    :param mongo_database: the mongodb database instance
    :param collection_name: the mongodb collection name
    :param search_filter: dict for the delete filter
    :param is_single: whether to delete a single document or multiple
    :param cache_id: identifier for redis; if not provided, uses the '_id' from the query
    """
    if cache_id is None:
        if CommonFields.ID in search_filter:
            cache_id = search_filter[CommonFields.ID]
        else:
            raise ValueError('cache_id must be provided if "_id" is not in the query.')

    cache_key = build_cache_key(mongo_database.name, cache_id, collection_name)

    try:
        mongo_collection = mongo_database[collection_name]
        if is_single:
            await mongo_collection.delete_one(search_filter)
        else:
            await mongo_collection.delete_many(search_filter)
    except Exception as e:
        raise Exception(f'Error deleting config in database: {e}') from e

    try:
        await bot.rdb.delete(cache_key)
    except Exception as e:
        logger.error(f"Redis delete failed: {e}")
