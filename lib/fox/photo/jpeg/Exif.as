package fox.photo.jpeg
{
	import fox.photo.exif.UsefulExif;
	import fox.photo.exif.ifd.IFDValue;

	public class Exif
	{
		public var tags:Array = [];
		public var userful:UsefulExif=new UsefulExif();
		private var TAGS:Object = new Object;
		private var m_exif:Object = new Object;
		public function hasKey(key:String):Boolean{
			return m_exif[key] != undefined;
		}
		public function getValue(key:String):Object{
			if(m_exif[key] == undefined) return null;
			return m_exif[key];
		}
	 
		public function getAllValues():Object {			
			return m_exif;
		}
		public function Exif()
		{
			
			
			TAGS[0x010e] = 'ImageDescription';
			TAGS[0x010f] = 'Make';
			TAGS[0X0110] = 'Model';
			TAGS[0x0112] = 'Orientation';
			TAGS[0x011a] = 'XResolution';
			TAGS[0x011b] = 'YResolution';
			TAGS[0x0128] = 'ResolutionUnit';
			TAGS[0x0131] = 'Software';
			TAGS[0x0132] = 'DateTime';
			TAGS[0x013e] = 'WhitePoint';
			TAGS[0x013f] = 'PrimaryChromaticities';
			TAGS[0x0221] = 'YCbCrCoefficients';
			TAGS[0x0213] = 'YCbCrPositioning';
			TAGS[0x0214] = 'ReferenceBlackWhite';
			TAGS[0x8298] = 'Copyright';
 			TAGS[0x0100] = "ImageWidth";
			TAGS[0x0101] = "ImageHeight";
			

			

			TAGS[0x829a] = 'ExposureTime';
			TAGS[0x829d] = 'FNumber';
			TAGS[0x8822] = 'ExposureProgram';
			TAGS[0x8827] = 'ISOSpeedRatings';
			TAGS[0x9000] = 'ExifVersion';
			TAGS[0x9003] = 'DateTimeOriginal';
			TAGS[0x9004] = 'DateTimeDigitized';
			TAGS[0x9101] = 'ComponentsConfiguration';
			TAGS[0x9102] = 'CompressedBitsPerPixel';
			TAGS[0x9201] = 'ShutterSpeedValue';
			TAGS[0x9202] = 'ApertureValue';
			TAGS[0x9203] = 'BrightnessValue';
			TAGS[0x9204] = 'ExposureBiasValue';
			TAGS[0x9205] = 'MaxApertureValue';
			TAGS[0x9206] = 'SubjectDistance';
			TAGS[0x9207] = 'MeteringMode';
			TAGS[0x9208] = 'LightSource';
			TAGS[0x9209] = 'Flash';
			TAGS[0x920a] = 'FocalLength';
			TAGS[0x927c] = 'MakerNote';
			TAGS[0x9286] = 'UserComment';
			TAGS[0x9290] = 'SubsecTime';
			TAGS[0x9291] = 'SubsecTimeOriginal';
			TAGS[0x9292] = 'SubsecTimeDigitized';
			TAGS[0xa000] = 'FlashPixVersion';
			TAGS[0xa001] = 'ColorSpace';
			TAGS[0xa002] = 'ExifImageWidth';
			TAGS[0xa003] = 'ExifImageHeight';
			TAGS[0xa004] = 'RelatedSoundFile';
			TAGS[0xa005] = 'ExifInteroperabilityOffset';
			TAGS[0xa20e] = 'FocalPlaneXResolution';
			TAGS[0xa20f] = 'FocalPlaneYResolution';
			TAGS[0xa210] = 'FocalPlaneResolutionUnit';
			TAGS[0xa215] = 'ExposureIndex';
			TAGS[0xa217] = 'SensingMethod';
			TAGS[0xa300] = 'FileSource';
			TAGS[0xa301] = 'SceneType';
			TAGS[0xa302] = 'CFAPattern';
 			TAGS[0xA432] = "LensSpecification";
			TAGS[0xA433] = "LensMake";
			TAGS[0xA434] = "LensModel";
			//
			TAGS[0xA403] = "WhiteBalance";
			 
			
			
		}
		
		public function initUseFul():void
		{
			//拍照日期
			var tag:IFDValue = this.findTagById(36867);
			if(tag){
				var t:String = ""+tag.value;
				t = t.replace(":",'-').replace(":",'-');
				userful.date =  DateFormatter.parseDateString(t);
			}else if((tag=this.findTagById(36868))!=null){
				var tt:String = ""+tag.value;
				tt = tt.replace(":",'-').replace(":",'-');
				userful.date =  DateFormatter.parseDateString(tt);
			}else if((tag=this.findTagById(306))!=null){
				var t2:String = ""+tag.value;
				t2 = t2.replace(":",'-').replace(":",'-');
				userful.date =  DateFormatter.parseDateString(t2);
			}
			//高度
			tag = this.findTagById(40963);
			if(tag){
				userful.height = int(tag.value);
			}
			//宽度
			tag = this.findTagById(40962);
			if(tag){
				userful.width = int(tag.value);
			}
			//Orientation  274 图片方向
			tag = this.findTagById(274);
			if(tag){
				userful.orientation = int(tag.value);
			}
			//Model 272  设备制造商
			tag = this.findTagById(272);
			if(tag){
				userful.model = ""+(tag.value);
			}
			//Make 271  使用设备
			tag = this.findTagById(271);
			if(tag){
				userful.make = ""+(tag.value);
			}
			for each (var i:IFDValue in tags) {
				if(TAGS[i.tag] != undefined){
					m_exif[TAGS[i.tag]] = i.value;
				}
			}
		}
		
		public function findTagById(id:uint):IFDValue{
			for each (var i:IFDValue in tags) 
			{
				if(i.tag==id){
					return i;
				}
			}
			return null;
		}
	}
}