package jp.seagirl.genius.threads
{
	import org.libspark.thread.Thread;

	public class GeniusThread extends Thread
	{
		public function GeniusThread()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 汎用的なデータオブジェクトです.
		 */		
		protected var data:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 汎用的なデータを追加するためのメソッドです。
		 * @param data
		 * @return  
		 */		
		public function addData(data:Object):GeniusThread
		{
			this.data = data;
			
			return this;
		}
		
		/**
		 * 汎用的なデータを保持しながら、Thread を開始するためのメソッドです.
		 * @param data 汎用的なデータオブジェクト
		 */		
		public function startWithData(data:Object):void
		{
			this.data = data;
			
			start();
		}
		
	}
}