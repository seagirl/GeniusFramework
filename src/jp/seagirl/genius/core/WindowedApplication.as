/**
 * Licensed under the MIT License
 * 
 * Copyright (c) 2008 seagirl
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */

package jp.seagirl.genius.core
{
	import mx.core.WindowedApplication;
	import mx.events.FlexEvent;

	/**
	 * ApplicationはAIRアプリケーションにおけるドキュメントクラスに相当するクラスです。
	 * 
	 * @author yoshizu 
	 */	
	public class WindowedApplication extends mx.core.WindowedApplication
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * コンストラクタ
		 */
		public function WindowedApplication()
		{
			super();
			
			styleName = 'plain';
			setStyle('color', '#000000');
			
			addEventListener(FlexEvent.PREINITIALIZE, preinitializeHandler);
			addEventListener(FlexEvent.INITIALIZE, initializeHandler); 
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			addEventListener(FlexEvent.APPLICATION_COMPLETE, applicationCompleteHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * FlexEvent.PREINITIALIZEで呼ばれるハンドラ
		 * @param event
		 */
		protected function preinitializeHandler(event:FlexEvent):void
		{
			
		}
		
		/**
		 * FlexEvent.INITIALIZEで呼ばれるハンドラ
		 * @param event
		 */
		protected function initializeHandler(event:FlexEvent):void
		{
			
		}
		
		/**
		 * FlexEvent.CREATION_COMPLETEで呼ばれるハンドラ
		 * @param event
		 */
		protected function creationCompleteHandler(event:FlexEvent):void
		{
			
		}
		
		/**
		 * FlexEvent.APPLICATION_COMPLETEで呼ばれるハンドラ
		 * @param event
		 */
		protected function applicationCompleteHandler(event:FlexEvent):void
		{
			
		}
		
	}
}