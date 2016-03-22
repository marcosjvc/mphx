package mphx.server;

import mphx.tcp.IConnection;

typedef EventFunction = Dynamic->IConnection->Void;

class EventManager
{
	var eventMap:Map<String,EventFunction>;

	public function new()
	{
		eventMap = new Map();
	}

	/**
	 * Add a event.
	 * If the event already exist, override the precedent callback
	 * @param	eventName
	 * @param	event
	 */
	public function on(eventName:String, event:EventFunction)
	{
		eventMap.set(eventName,event);
	}
	
	/**
	 * Remove an event if exist
	 * @param	eventName
	 */
	public function remove(eventName:String)
	{
		if (eventMap.exists(eventName)) 
		{
			eventMap.set(eventName,null);
			eventMap.remove(eventName);
		}
	}

	/**
	 * call an event if exist.
	 * If the callback associed to the event is null. nothing append
	 * @param	eventName
	 * @param	data
	 * @param	sender
	 */
	public function callEvent(eventName:String, data:Dynamic, sender:IConnection)
	{
		//If an event with that name exists.
		if (eventMap.exists(eventName)) 
		{
			if(eventMap.get(eventName) != null)
				eventMap.get(eventName)(data, sender);
		}
	}
}
