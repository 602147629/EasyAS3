/*
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-09-27 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.vinci.display 
{
	import org.easyas3.utils.MathUtil;
	import org.easyas3.vinci.utils.BitmapBuffer;
	
	/**
	 * ... 精灵序列图组位图动画 ...
	 * @author Jerry
	 */
	public class SpriteSheetGroupBitmapMovie extends SpriteSheetBitmapMovie 
	{
		/**
		 * 当前正在使用的组
		 */
		protected var _currentGroup:SpriteSheetGoup;
		
		/**
		 * 构造函数
		 * @param	spriteSheetBmpInfo:SpriteSheetBitmapInfo — 精灵序列图位图数据信息
		 * @param	frameRate:Number (default = NaN) — 帧速率
		 * @param	direction:String (default = "horizontal") — 精灵序列图布局方向
		 * @param	centerPointPosition:String (default = "center") — 位图动画中心点位置
		 */
		public function SpriteSheetGroupBitmapMovie(spriteSheetBmpInfo:SpriteSheetBitmap = null, frameRate:Number = NaN, direction:String = "horizontal", 
													centerPointPosition:String = "center") 
		{
			super(spriteSheetBmpInfo, frameRate, direction, centerPointPosition);
			
		}
		
		/**
		 * 当前正在使用的组
		 */
		public function get currentGroup():SpriteSheetGoup 
		{
			return _currentGroup;
		}
		
		/**
		 * 当前正在使用的组
		 */
		public function set currentGroup(group:SpriteSheetGoup):void 
		{
			var bitmaps:Array = [];
			var newRowCount:int;
			var newColumnCount:int;
			var startRowIndex:int = group.startRowIndex;
			var endRowIndex:int = group.endRowIndex;
			var startColumnIndex:int = group.startColumnIndex;
			var endColumnIndex:int = group.endColumnIndex;
			
			if (_spriteSheetBmpInfo == null)
			{
				//如果位图数组为空的话则不继续执行
				return;
			}
			
			//验证边界值
			startRowIndex = MathUtil.checkValueFromRange(startRowIndex, 0, row - 1);
			endRowIndex = MathUtil.checkValueFromRange(endRowIndex, 0, row - 1);
			startColumnIndex = MathUtil.checkValueFromRange(startColumnIndex, 0, column - 1);
			endColumnIndex = MathUtil.checkValueFromRange(endColumnIndex, 0, column - 1);
			
			//得到新的行数和列数
			newRowCount = endRowIndex - startRowIndex + 1;
			newColumnCount = endColumnIndex - startColumnIndex + 1;
			
			_currentGroup = group;
			
			for (var i:int = startRowIndex; i < endRowIndex + 1; i++) 
			{
				var columnBmps:Array = [];
				
				for (var j:int = startColumnIndex; j < endColumnIndex + 1; j++) 
				{
					columnBmps.push(spriteSheetBitmaps[i][j]);
				}
				
				bitmaps.push(columnBmps);
			}
			
			frames = BitmapBuffer.generateFrames(bitmaps, newRowCount, newColumnCount, direction);
		}
	}

}