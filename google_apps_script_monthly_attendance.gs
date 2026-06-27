const SECRET_KEY = 'facepass_secret_123';

const HEADERS = [
  'ID',
  'Ma NV',
  'Ten NV',
  'Ngay',
  'Gio',
  'Loai',
  'Trang thai',
  'Do giong',
  'GPS',
  'IP',
];

function doPost(e) {
  try {
    const body = JSON.parse(e.postData.contents);

    if (body.secret !== SECRET_KEY) {
      return jsonResponse({
        success: false,
        message: 'Invalid secret',
      });
    }

    const checkedAt = new Date(body.checkedAt);
    const sheetName = Utilities.formatDate(
      checkedAt,
      'Asia/Ho_Chi_Minh',
      'MM-yyyy'
    );
    const sheet = getOrCreateMonthlySheet(sheetName);

    sheet.appendRow([
      body.id || '',
      body.userId || '',
      body.userName || '',
      Utilities.formatDate(checkedAt, 'Asia/Ho_Chi_Minh', 'dd/MM/yyyy'),
      Utilities.formatDate(checkedAt, 'Asia/Ho_Chi_Minh', 'HH:mm:ss'),
      body.type || '',
      body.status || '',
      body.similarity || '',
      body.gpsLocation || '',
      body.ipAddress || '',
    ]);

    return jsonResponse({
      success: true,
      sheetName: sheetName,
      message: 'Saved',
    });
  } catch (error) {
    return jsonResponse({
      success: false,
      message: error.toString(),
    });
  }
}

function getOrCreateMonthlySheet(sheetName) {
  const spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  let sheet = spreadsheet.getSheetByName(sheetName);

  if (!sheet) {
    sheet = spreadsheet.insertSheet(sheetName);
    sheet.appendRow(HEADERS);
    sheet.setFrozenRows(1);
    sheet.getRange(1, 1, 1, HEADERS.length).setFontWeight('bold');
    sheet.autoResizeColumns(1, HEADERS.length);
  }

  return sheet;
}

function jsonResponse(data) {
  return ContentService
    .createTextOutput(JSON.stringify(data))
    .setMimeType(ContentService.MimeType.JSON);
}
