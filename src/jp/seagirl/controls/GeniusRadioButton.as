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

package jp.seagirl.controls
{
	import mx.controls.RadioButton;
	
	//--------------------------------------
	//  Styles
	//--------------------------------------
	
	/**
	 *  backgroundColorで定義されている色の透明度です。
	 *  有効な値の範囲は 0.0 から 1.0 です。
	 */
	[Style(name="backgroundAlpha", type="Number", inherit="no")]
	
	/**
	 *  コンポーネントの背景色です。
	 */
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no")]
	
	/**
	 *  コンポーネントの角に付いている丸みの半径です。
	 */
	[Style(name="cornerRadius", type="uint", inherit="no")]
	
	/**
	 * AdvancedRadioButtonはmx.controls.RadioButtonの拡張です。 
	 * StyleにbackgroundAlpha, backgroundColor, cornerRadiusを追加しています。
	 * 
	 * @author yoshizu
	 * @see mx.controls.RadioButton
	 */
	public class GeniusRadioButton extends mx.controls.RadioButton
	{	
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * コンストラクタ
		 */
		public function GeniusRadioButton()
		{
			super();	
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			graphics.clear();
			
			if (getStyle('backgroundColor') != undefined)
				drawRoundRect(0, 0, width, height, getStyle('cornerRadius'), getStyle('backgroundColor'), getStyle('backgroundAlpha'));
		}
	}
}