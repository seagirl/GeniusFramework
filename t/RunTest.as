package
{
	import flash.display.Sprite;
	import org.libspark.as3unit.runner.AS3UnitCore;

	public class RunTest extends Sprite
	{
		public function RunTest()
		{
			AS3UnitCore.main(AllTests);
		}
	}
}