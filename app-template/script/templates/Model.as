package [% package %].models
{
	import jp.seagirl.genius.models.Model;

	public class [% name %] extends Model
	{
		private static var _instance:[% name %];
		
		public static function get instance():[% name %]
		{
			if (_instance == null)
				_instance = new [% name %]();
			return _instance;
		}
		
		public function [% name %]()
		{
			if (_instance != null)
				throw new Error("Public construction not allowed.");
		}
		
	}
}