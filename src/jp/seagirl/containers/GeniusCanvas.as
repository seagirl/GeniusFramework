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

package jp.seagirl.containers
{
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	import mx.containers.Canvas;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	//--------------------------------------
	//  Styles
	//--------------------------------------
	
	/**
	* fillColorsで定義された色の透明度です。
	*/		
	[Style(name="fillAlphas", type="Array", format="Number", inherit="no")]
	
	/**
	* コンポーネントのグラデーション背景色です。
	*/
	[Style(name="fillColors", type="Array", format="Color", inherit="no")]

	/**
	 * AdvancedCanvasはmx.containers.Canvasを拡張したクラスです。
	 * StyleにfillAlphasとfillColorsを追加しています。
	 * 
	 * @author yoshizu 
	 * @see mx.containers.Canvas
	 */	
	public class GeniusCanvas extends Canvas
	{
		//--------------------------------------------------------------------------
		//
		//  Constructors
		//
		//--------------------------------------------------------------------------
		
		/** 
		 * コンストラクタ
		 */		
		public function GeniusCanvas()
		{
			super();
			
			if (!StyleManager.getStyleDeclaration('AdvancedCanvas')) {
				var newStyleDeclaration:CSSStyleDeclaration = new CSSStyleDeclaration();
				newStyleDeclaration.setStyle('fillAlphas', [0, 0]);
				newStyleDeclaration.setStyle('fillColors', [0xFFFFFF, 0x000000]);
				StyleManager.setStyleDeclaration('AdvancedCanvas', newStyleDeclaration, true);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		private var fillAlphasData:Array;
		
		/**
		 * @private 
		 */		
		private var bFillAlphasChanged:Boolean = true;
		
		/**
		 * @private 
		 */	
		private var fillColorsData:Array;
		
		/**
		 * @private 
		 */	
		private var bFillColorsChanged:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Overidden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */			
		override public function styleChanged(styleProp:String):void
		{
			super.styleChanged(styleProp);
			
			if (styleProp == 'fillAlphas') {
				bFillAlphasChanged = true;
				invalidateDisplayList();
				return;
			}
			
			if (styleProp == 'fillColors') {
				bFillColorsChanged = true;
				invalidateDisplayList();
				return;
			}
		}
		
		/**
		 * @private
		 */			
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if (bFillAlphasChanged == true || bFillColorsChanged == true) {
				if (bFillAlphasChanged == true)
					fillAlphasData = getStyle('fillAlphas');
				
				if (bFillColorsChanged == true)
					fillColorsData = getStyle('fillColors');
					
				var matrix:Matrix = new Matrix();
				matrix.createGradientBox(unscaledWidth, unscaledHeight, Math.PI / 2, 0, 0);
				
				graphics.clear();
				graphics.beginGradientFill(GradientType.LINEAR, fillColorsData, fillAlphasData, [0x00, 0xFF], matrix);
				graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			}
		}
		
	}
}