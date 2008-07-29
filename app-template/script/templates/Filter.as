package [% package %]
{
	import jp.seagirl.genius.models.IDataFilter;
	
	public class [% name %] implements IDataFilter
	{
		public function [% name %](condition:Object)
		{
			this.condition = condition;
		}
		
		private var condition:Object;

		public function apply(rawdata:XMLList):XMLList
		{	
			if (rawdata == null)
				return null;
			
			return rawdata.copy();
		}
		
	}
}