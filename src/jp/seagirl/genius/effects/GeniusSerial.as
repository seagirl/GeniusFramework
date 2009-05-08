package jp.seagirl.genius.effects
{
	import mx.effects.Sequence;
	
	public class GeniusSerial extends GeniusCompositeEffect
	{
		public function GeniusSerial(... rest)
		{
			var l:int = rest.length;
			
			for (var i:int = 0; i < l; i++)
			{
				effects.push(rest[i]);
			}
			
			root = new Sequence();
		}
		
	}
}