package mphx.core;

import mphx.tcp.Protocol;

class EventManager {

	var eventMap:Map<String,Either<(Dynamic->Protocol->Void), (Dynamic->Void)>>;

	public function new () {
		eventMap = new Map<String,Either<(Dynamic->Protocol->Void), (Dynamic->Void)>>();
	}

	public function on (eventName,event:Either<(Dynamic->Protocol->Void), (Dynamic->Void)>){
		eventMap.set(eventName,event);
	}
	public function callEvent (eventName,data,sender){
		if (eventMap.exists(eventName) == false){
			//trace("Called event "+eventName+". No listener.");
			//return;
		}
		switch(eventMap.get(eventName).type){
		case Left(eventWithSender): eventWithSender(data,sender);
		case Right(eventWithoutSender): eventWithoutSender(data);
		}
		trace("Event recieved: " + eventName);

	}

}




abstract Either<L, R> (haxe.ds.Either<L, R>)
{
	inline function new (e:haxe.ds.Either<L, R>)
    {
        this = e;
    }

	public var type (get, never) : haxe.ds.Either<L, R>;
	inline function get_type () : haxe.ds.Either<L, R>
    {
        return this;
    }

	@:from static inline function fromLeft<L> (left:L)
    {
        return new Either(Left(left));
    }

	@:from static inline function fromRight<R> (right:R)
    {
        return new Either(Right(right));
    }
}
