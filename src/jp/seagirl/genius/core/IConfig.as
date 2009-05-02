package jp.seagirl.genius.core
{
	public interface IConfig
	{
		function get applicationName():String;
		function set applicationName(value:String):void;
		
		function get applicationVersion():String;
		function set applicationVersion(value:String):void;
		
		function get defaultState():Object;
		function set defaultState(value:Object):void;
	}
}