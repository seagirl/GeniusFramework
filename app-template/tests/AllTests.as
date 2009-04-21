package
{
	import org.libspark.as3unit.runners.Suite;
	import [% package %].[% name %]AllTests;
	
	public class AllTests
	{
		public static const RunWith:Class = Suite;
		
		public static const SuiteClasses:Array =
		[
			[% name %]AllTests
		];
	}
}