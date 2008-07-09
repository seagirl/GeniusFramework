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
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	//--------------------------------------
	//  Styles
	//--------------------------------------
	
	/**
	 * 
	 */
	[Style(name="paddingTop", type="int", inherit="no")]
	
	/**
	 * 
	 */
	[Style(name="paddingRight", type="int", inherit="no")]
	
	/**
	 * 
	 */
	[Style(name="paddingBottom", type="int", inherit="no")]
	
	/**
	 * 
	 */
	[Style(name="paddingLeft", type="int", inherit="no")]
	
	/**
	 * 
	 */
	[Style(name="borderRollOverColor", type="uint", inherit="no")]
	
	/**
	 * 
	 */
	[Style(name="backgroundRollOverColor", type="uint", inherit="no")]
	
	/**
	 * 
	 */
	[Style(name="borderSelectedColor", type="uint", inherit="no")]
	
	/**
	 * 
	 */
	[Style(name="backgroundSelectedColor", type="uint", inherit="no")]

	/**
	 * SimpleButtonはシンプルなボタンコントロールを提供するクラスです。
	 * 
	 * @author yoshizu 
	 */	
	public class SimpleButton extends Canvas
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * コンストラクタ 
		 */		
		public function SimpleButton()
		{
			super();
			
			if (!StyleManager.getStyleDeclaration('SimpleButton')) {
				var newStyleDeclaration:CSSStyleDeclaration = new CSSStyleDeclaration();
				newStyleDeclaration.setStyle('paddingTop', 0);
				newStyleDeclaration.setStyle('paddingRight', 0);
				newStyleDeclaration.setStyle('paddingBottom', 0);
				newStyleDeclaration.setStyle('paddingLeft', 0);
				StyleManager.setStyleDeclaration('SimpleButton', newStyleDeclaration, true);
			}
			
			labelComponent = new Label();
			addChild(labelComponent);
			
			useHandCursor = true;
			buttonMode = true;
			mouseChildren = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, rollOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, rollOutHandler);
		}
			
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		private var labelComponent:Label;
		
		/**
		 * @private 
		 */	
		private var styleChange:Boolean = true;
		
		/**
		 * @private 
		 */	
		private var borderColor:uint;
		
		/**
		 * @private 
		 */	
		private var backgroundColor:uint;
		
		/**
		 * @private 
		 */	
		private var color:uint;
		
		/**
		 * @private 
		 */	
		private var borderRollOverColor:uint;
		
		/**
		 * @private 
		 */	
		private var backgroundRollOverColor:uint;
		
		/**
		 * @private 
		 */	
		private var textRollOverColor:uint;
		
		/**
		 * @private 
		 */	
		private var borderSelectedColor:uint;
		
		/**
		 * @private 
		 */	
		private var backgroundSelectedColor:uint;
		
		/**
		 * @private 
		 */	
		private var textSelectedColor:uint;
		
		//--------------------------------------------------------------------------
		//
		//  Overridden properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------
		//  enabled
		//--------------------------------------
		
		/**
		 * @private 
		 */	
		override public function set enabled(value:Boolean):void
		{
			super.enabled = true;
			
			if (labelComponent != null) {
				labelComponent.enabled = value;
				
				if (value == true) {
					if (!hasEventListener(MouseEvent.MOUSE_OVER) ||
						!hasEventListener(MouseEvent.MOUSE_OUT)
					) {
						useHandCursor = true;
						setStyle('borderColor', borderColor);
						addEventListener(MouseEvent.MOUSE_OVER, rollOverHandler);
						addEventListener(MouseEvent.MOUSE_OUT, rollOutHandler);
					}
				}
				else {
					if (hasEventListener(MouseEvent.MOUSE_OVER) ||
						hasEventListener(MouseEvent.MOUSE_OUT)
					) {
						useHandCursor = false;
						setStyle('borderColor', labelComponent.getStyle('disabledColor'));
						removeEventListener(MouseEvent.MOUSE_OVER, rollOverHandler);
						removeEventListener(MouseEvent.MOUSE_OUT, rollOutHandler);
					}
				}	
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------
		//  text
		//--------------------------------------
		
		/**
		 * @private 
		 */	
		private var _text:String;
		
		/**
		 * ラベル用のテキストです。
		 */	
		public function get text():String
		{
			return labelComponent.text;
		}
		
		/**
		 * @private 
		 */	
		public function set text(value:String):void
		{
			labelComponent.text = value;
		}
		
		//--------------------------------------
		//  selected
		//--------------------------------------
		
		/**
		 * @private 
		 */	
		private var _selected:Boolean;
		
		/**
		 * 選択されているかどうかを表します。
		 */	
		public function get selected():Boolean
		{
			return _selected;
		}
		
		/**
		 * @private 
		 */	
		public function set selected(value:Boolean):void
		{
			if (_selected != value) {
				_selected = value;
				select();
			}
		}
		
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
			
			if (styleProp == 'paddingTop' ||
				styleProp == 'paddingRight' ||
				styleProp == 'paddingBottom' ||
				styleProp == 'paddingLeft' ||
				styleProp == 'borderColor' ||
				styleProp == 'backgroundColor' ||
				styleProp == 'color' ||
				styleProp == 'borderRollOverColor' ||
				styleProp == 'backgroundRollOverColor' ||
				styleProp == 'textRollOverColor' ||
				styleProp == 'borderSelectedColor' ||
				styleProp == 'backgroundSelectedColor' ||
				styleProp == 'textSelectedColor'
			) {
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
			
			if (styleChange == true) {
				labelComponent.setStyle('paddingTop', getStyle('paddingTop'));
				labelComponent.setStyle('paddingRight', getStyle('paddingRight'));
				labelComponent.setStyle('paddingBottom', getStyle('paddingBottom'));
				labelComponent.setStyle('paddingLeft', getStyle('paddingLeft'));
				
				borderColor = getStyle('borderColor');
				backgroundColor = getStyle('backgroundColor');
				color = getStyle('color');
				borderRollOverColor = getStyle('borderRollOverColor');
				backgroundRollOverColor = getStyle('backgroundRollOverColor');
				textRollOverColor = getStyle('textRollOverColor');
				borderSelectedColor = getStyle('borderSelectedColor');
				backgroundSelectedColor = getStyle('backgroundSelectedColor');
				textSelectedColor = getStyle('textSelectedColor');
			}
			styleChange = true;	
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */	
		private function select():void
		{
			styleChange = false;
			if (selected == true) {
				setStyle('borderColor', borderSelectedColor);
				setStyle('backgroundColor', backgroundSelectedColor);
				setStyle('color', textSelectedColor);
			}
			else {
				setStyle('borderColor', borderColor);
				setStyle('backgroundColor', backgroundColor);
				setStyle('color', color);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */	
		private function rollOverHandler(event:MouseEvent):void
		{
			if (selected == false) {
				styleChange = false;
				setStyle('borderColor', borderRollOverColor);
				setStyle('backgroundColor', backgroundRollOverColor);
				setStyle('color', textRollOverColor);
			}
		}
		
		/**
		 * @private 
		 */	
		private function rollOutHandler(event:MouseEvent):void
		{
			if (selected == false) {
				styleChange = false;
				setStyle('borderColor', borderColor);
				setStyle('backgroundColor', backgroundColor);
				setStyle('color', color);
			}
		}
	}
}