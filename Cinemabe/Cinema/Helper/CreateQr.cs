using Aspose.BarCode.Generation;

namespace Cinema.Helper
{
    public class QRCodeGenerator
    {
        [Obsolete]
        public void GenerateQRCode(string qrContent, string filePath)
        {
            // Tạo đối tượng BarcodeGenerator
            BarcodeGenerator gen = new(EncodeTypes.QR, qrContent);
            gen.Parameters.Barcode.XDimension.Pixels = 4;
            gen.Parameters.Barcode.QR.QrVersion = QRVersion.Auto;

            // Đặt loại mã hóa ForceMicroQR
            gen.Parameters.Barcode.QR.QrEncodeType = QREncodeType.ForceMicroQR;

            // Lưu ảnh mã QR vào file
            gen.Save(filePath, BarCodeImageFormat.Png);
        }
    }
}