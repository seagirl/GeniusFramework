package
{
	import flash.display.Sprite;
	import org.libspark.as3unit.runner.AS3UnitCore;

	public class [% name %]Test extends Sprite
	{
		public function [% name %]Test()
		{
			AS3UnitCore.main(AllTests);
		}
	}
}