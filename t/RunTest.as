package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.InvokeEvent;
	
	import org.libspark.as3unit.runner.AS3UnitCore;

	public class RunTest extends Sprite
	{
		public function RunTest()
		{
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, initialize);
		}
		
		private function initialize(event:InvokeEvent):void
		{
			trace("--------------------------------------------------------------------------------");
			trace("Genius Framework 2");
			trace("");
			
			var args:Array = event.arguments;
			
			trace("[RunAllTests at " + new Date() + "]");
			AS3UnitCore.main(AllTests);
			
			trace("");
			NativeApplication.nativeApplication.exit();	
		}
	}
}