Attribute VB_Name = "look_for"
Public filename1 As Variant

Sub getimportfilename() '�����ļ�����
    Dim filt As String
    Dim filterindex As Integer
    Dim title As String
    filt = "text files (*.txt),*.txt," & _
    "comma separated files (*.csv),*.csv," & _
    "ascii files(*. asc),*.asc," & _
    "all files (*.*),*.*"
    filterindex = 4
    title = "��ѡ���ļ�"
    filename1 = Application.GetOpenFilename(filefilter:=filt, filterindex:=filterindex, title:=title)
End Sub


