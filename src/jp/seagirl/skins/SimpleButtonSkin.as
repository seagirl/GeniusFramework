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
 
 package jp.seagirl.skins
{
	import mx.skins.ProgrammaticSkin;

	/**
	 * シンプルなボタンのスキンです。
	 * 
	 * @author yoshizu 
	 */	
	public class SimpleButtonSkin extends ProgrammaticSkin
	{		
		public function SimpleButtonSkin()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			graphics.clear();
			
			var fillColor:uint = 0xFFFFFF;
			var fillAlpha:Number = 1.0;
			var cornerRadius:Number = 0;
			
			if (getStyle('cornerRadius'))
				cornerRadius = getStyle('cornerRadius');
			
			switch (name)
			{
				case "upSkin":
				{
					if (getStyle('backgroundColor'))
						fillColor = getStyle('backgroundColor');
					
					if (getStyle('backgroundAlpha'))
						fillAlpha = getStyle('backgroundAlpha');
					
					break;
				}
				case "overSkin":
				{
					if (getStyle('backgroundOverColor'))
						fillColor = getStyle('backgroundOverColor');
					else if (getStyle('backgroundColor'))
						fillColor = getStyle('backgroundColor');
							
					if (getStyle('backgroundOverAlpha'))
						fillAlpha = getStyle('backgroundOverAlpha');
					else if (getStyle('backgroundAlpha'))
						fillAlpha = getStyle('backgroundAlpha');
						
					break;
				}
				case "downSkin":
				{
					if (getStyle('backgroundDownColor'))
						fillColor = getStyle('backgroundDownColor');
					else if (getStyle('backgroundColor'))
						fillColor = getStyle('backgroundColor');
							
					if (getStyle('backgroundDownAlpha'))
						fillAlpha = getStyle('backgroundDownAlpha');
					else if (getStyle('backgroundAlpha'))
						fillAlpha = getStyle('backgroundAlpha');
						
					break;
				}
				case "disabledSkin":
				{
					if (getStyle('backgroundDisabledColor'))
						fillColor = getStyle('backgroundDisabledColor');
					else if (getStyle('backgroundColor'))
						fillColor = getStyle('backgroundColor');
							
					if (getStyle('backgroundDisabledAlpha'))
						fillAlpha = getStyle('backgroundDisabledAlpha');
					else if (getStyle('backgroundAlpha'))
						fillAlpha = getStyle('backgroundAlpha');

					break;
				}
			}
			
			graphics.beginFill(fillColor, fillAlpha);
			graphics.drawRoundRect(0, 0, width, height, cornerRadius, cornerRadius);
			graphics.endFill();
		}
		
	}
}