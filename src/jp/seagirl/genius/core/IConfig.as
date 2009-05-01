package jp.seagirl.genius.core
{
	public interface IConfig
	{
		function get applicationName():String;
		function get applicationVersion():String;
		function get defaultState():Object;
	}
}