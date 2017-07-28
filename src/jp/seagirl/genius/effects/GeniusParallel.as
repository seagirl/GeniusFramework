package jp.seagirl.genius.effects
{
	import mx.effects.Parallel;
	
	public class GeniusParallel extends GeniusCompositeEffect
	{
		public function GeniusParallel(... rest)
		{
			var l:int = rest.length;
			
			for (var i:int = 0; i < l; i++)
			{
				effects.push(rest[i]);
			}
			
			root = new Parallel();
		}

	}
}