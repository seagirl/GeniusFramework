package jp.seagirl.genius.effects
{
	import mx.effects.CompositeEffect;
	
	public class GeniusCompositeEffect
	{
		public function GeniusCompositeEffect()
		{
			
		}
		
		protected var root:CompositeEffect;
		
		protected var effects:Array = [];
		
		public function create():CompositeEffect
		{
			var l:int = effects.length;
			
			for (var i:int = 0; i < l; i++)
			{
				root.addChild(effects[i].create());
			}
			
			return root;	
		}

	}
}