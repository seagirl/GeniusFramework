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

var userAgent = navigator.userAgent;
var appName = navigator.appName;
var swfContainer = null;

function initializeMouseWheel()
{
	if (userAgent.indexOf('Mac') > -1)
	{
		swfContainer = document.getElementById(swfContainerId);
		
		if (swfContainer != null)
		{
			if (swfContainer.addEventListener)
				swfContainer.addEventListener('DOMMouseScroll', mouseWheelHandler, false);
			swfContainer.onmousewheel = mouseWheelHandler;
		}
	}
}

function mouseWheelHandler(event)
{
	var delta = 0;
	var mouseX;
	var mouseY;
	
	if (!event)
		event = window.event;
	
	if (event.detail)
		delta = -event.detail;
	else if (event.wheelDelta)
	{
		delta = event.wheelDelta;
		if (window.opera)
			delta = -delta;
	}
	
	if ((userAgent.indexOf('Firefox') > -1) || (userAgent.indexOf('Camino') > -1))
	{
		mouseX = event.layerX;
		mouseY = event.layerY;
	}
	else
	{
		mouseX = event.offsetX;
		mouseY = event.offsetY;
	}
		
	var movie = document.getElementById(swfId);
	if (movie.dispatchMouseWheelEvent)
		movie.dispatchMouseWheelEvent((delta >= 0) ? 1 : -1, mouseX, mouseY);
	
	if (event.preventDefault)
		event.preventDefault();
		
	event.returnValue = false;
}