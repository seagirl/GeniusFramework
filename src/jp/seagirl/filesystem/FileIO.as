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

package jp.seagirl.filesystem
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.utils.UIDUtil;
	
	/**
	 * FileIOを簡単に扱うためのクラスです。
	 * 
	 * @author yoshizu
	 * 
	 * @example XMLを文字列としてファイルに読み書きする例
	 * <listing version="3.0">
	 * var xml:XML = &lt;hoge&gt;fuga&lt;/hoge&gt;;
	 * 
	 * var fileIO:FileIO = new FileIO();
	 * fileIO.writeString('xml/hoge.xml', xml.toXMLString());
	 * 
	 * var string:String = fileIO.readString('xml/hoge/xml');
	 * var restoredXml:XML = new XML(string);
	 * </listing>
	 */	
	public class FileIO
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * コンストラクタ
		 * 
		 * @param storage ストレージの場所
		 * @see flash.desktop.File
		 */		
		public function FileIO(storage:File = null)
		{
			if (storage != null)
				_storage = storage;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		private var _storage:File = File.applicationStorageDirectory;
		
		/**
		 * ストレージの場所
		 * 
		 * @default File.applicationStorageDirectory
		 * @see flash.desktop.File
		 */		
		public function get storage():File
		{
			return _storage;
		}
		
		/**
		 * @private 
		 */		
		public function set storage(value:File):void
		{
			_storage = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * ファイルをFile型として読み込みます。
		 * 
		 * @param ファイルへのパス
		 * @return 読み込んだデータ
		 */		
		public function readFile(path:String):File
		{				
			return storage.resolvePath(path);
		}
		
		/**
		 * ファイルをString型のデータとして読み込みます。
		 * 
		 * @param ファイルへのパス
		 * @return 読み込んだデータ
		 */		
		public function readString(path:String):String
		{
			var value:String;
			var file:File = storage.resolvePath(path);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			value = fileStream.readUTFBytes(file.size);
			fileStream.close();
			
			return value;
		}
		
		/**
		 * ファイルをObject型のデータとして読み込みます。
		 * 
		 * @param ファイルへのパス
		 * @return 読み込んだデータ
		 */		
		public function readObject(path:String):Object
		{
			var value:Object;
			var file:File = storage.resolvePath(path);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			value = fileStream.readObject();
			fileStream.close();
			
			return value;
		}
		
		/**
		 * ファイルをByteArray型のデータとして読み込みます。
		 * 
		 * @param ファイルへのパス
		 * @return 読み込んだデータ
		 */				
		public function readBinary(path:String):ByteArray
		{
			var value:ByteArray;
			var file:File = storage.resolvePath(path);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			fileStream.readBytes(value);
			fileStream.close();
			
			return value;
		}		
		
		/**
		 * String型のデータをファイルに書き込みます。
		 * 
		 * @param ファイルへのパス
		 * @param 書き込むデータ
		 * @return 書き込みに成功したかどうか  
		 */		
		public function writeString(path:String, value:String):Boolean
		{
			var tmpFile:File = storage.resolvePath(UIDUtil.createUID());
			var saveAs:File = storage.resolvePath(path);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(tmpFile, FileMode.UPDATE);
			fileStream.writeUTFBytes(value);
			fileStream.close();
			
			if (saveAs.exists)
				saveAs.deleteFile();
			tmpFile.moveTo(saveAs);
			
			return true;
		}
		
		/**
		 * Object型のデータをファイルに書き込みます。
		 *  
		 * @param ファイルへのパス
		 * @param 書き込むデータ
		 * @return 書き込みに成功したかどうか  
		 * 
		 */		
		public function writeObject(path:String, value:Object):Boolean
		{
			var tmpFile:File = storage.resolvePath(UIDUtil.createUID());
			var saveAs:File = storage.resolvePath(path);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(tmpFile, FileMode.UPDATE);
			fileStream.writeObject(value);
			fileStream.close();
			
			if (saveAs.exists)
				saveAs.deleteFile();
			tmpFile.moveTo(saveAs);
			
			return true;
		}
		
		/**
		 * ByteArray型のオブジェクトをファイルに書き込みます。
		 * 
		 * @param ファイルへのパス
		 * @param 書き込むデータ
		 * @return 書き込みに成功したかどうか  
		 */		
		public function writeBinary(path:String, value:ByteArray):Boolean
		{
			var tmpFile:File = storage.resolvePath(UIDUtil.createUID());
			var saveAs:File = storage.resolvePath(path);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(tmpFile, FileMode.UPDATE);
			fileStream.writeBytes(value, 0, value.length);
			fileStream.close();
			
			if (saveAs.exists)
				saveAs.deleteFile();
			tmpFile.moveTo(saveAs);
			
			return true;
		}

	}
}