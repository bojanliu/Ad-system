VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} ������ 
   Caption         =   "Ad System"
   ClientHeight    =   10170
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   19590
   OleObjectBlob   =   "������.frx":0000
   StartUpPosition =   2  '��Ļ����
End
Attribute VB_Name = "������"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim fn1 As String
Dim fn2 As String
Dim fn3 As String
Dim fn4 As String
Dim n3 As String
Dim d1 As String
Dim b1 As Variant
Dim x As Byte '��ȡ��ҳ���ݹ�������
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Const WS_MAXIMIZEBOX = &H10000
Private Const WS_MINIMIZEBOX = &H20000
Private Const GWL_STYLE = (-16)

Private Sub CommandButton1_Click() '�Զ���¼��վ
    If ComboBox1.Value = "PROϵͳ" Then
        Call Gotopro
        MsgBox "��¼�ɹ���", , "Ad system"
    ElseIf ComboBox1.Value = "SEMϵͳ" Then
        Call Gotosem
        MsgBox "��¼�ɹ���", , "Ad system"
    Else
        Exit Sub
    End If
End Sub

Private Sub CommandButton3_Click() '����ҳ
        Select Case ComboBox2.Value
            Case "��Ͷ��"
                x = 1
            Case "��Ͷ��ά��"
                x = 2
            Case "��Ͷ��ά��"
                x = 3
            Case Else
                Exit Sub
        End Select
        WebBrowser1.Navigate "http://pro.vemic.com/system/industry/corp_manage.php?ads_flag[" & x & "]=1&disp_rows=1000" '��proϵͳָ����ҳ
End Sub

Private Sub CommandButton2_Click() '��ȡ��ҳ����
    Dim i As Integer, j As Integer
    Sheets("PRO���ݴ������").Cells.Delete '�����һ�β�������
    If x = 1 Or x = 2 Or x = 3 Then '�ж�ǰһ�����Ƿ����
        Set dmt = WebBrowser1.Document
        Set r = dmt.all.tags("table")(3).Rows
        For i = 0 To r.Length - 1
            For j = 0 To r(i).Cells.Length - 1
                Sheets(1).Cells(i + 1, j + 1) = r(i).Cells(j).innerText
            Next
        Next
    Else
        Exit Sub
    End If
    MsgBox "�����ѻ�ȡ��ɣ�", 64, "Ad system"
End Sub

Private Sub UserForm_Initialize()
    Dim hWndForm As Long '�ڴ�������������С����ť
    Dim iStyle As Long '�ڴ�������������С����ť
    hWndForm = FindWindow("ThunderDFrame", Me.Caption) '�ڴ�������������С����ť
    iStyle = GetWindowLong(hWndForm, GWL_STYLE) '�ڴ�������������С����ť
    iStyle = iStyle Or WS_MINIMIZEBOX '�ڴ�������������С����ť
    iStyle = iStyle Or WS_MAXIMIZEBOX '�ڴ�������������С����ť
    SetWindowLong hWndForm, GWL_STYLE, iStyle '�ڴ�������������С����ť
    
    VIPmodulus.List() = Array("1.5", "2.0", "2.5", "3.0") '��ʼ�����Ͽ�����
    ComboBox1.List() = Array("PROϵͳ", "SEMϵͳ") '��ʼ�����Ͽ�����
    ComboBox2.List() = Array("��Ͷ��", "��Ͷ��ά��", "��Ͷ��ά��")

End Sub

Private Sub CB1_Click() '�����ļ���1
    Dim arr As Variant
    Call getimportfilename
    If filename1 = False Then
        name1.Value = ""
    Else
        arr = Split(filename1, "\")
        fn1 = filename1
        name1.Value = arr(UBound(arr))
    End If
End Sub

Private Sub CB2_Click() '�����ļ���2
    Dim arr As Variant
    Call getimportfilename
    If filename1 = False Then
        name2.Value = ""
    Else
        arr = Split(filename1, "\")
        fn2 = filename1
        name2.Value = arr(UBound(arr))
    End If
End Sub

Private Sub ȷ���ļ�����_Click() '��������
    Dim n1 As String
    Dim n2 As String
    n1 = name1.Value
    n2 = name2.Value
    If n1 = "" Or n2 = "" Then '�ж�ǰһ�����Ƿ����
        Exit Sub
    Else
        Workbooks.Open filename:=fn1
        Workbooks.Open filename:=fn2
        With Workbooks(ThisWorkbook.Name)
            Workbooks(n1).Sheets(1).Copy Before:=.Sheets(1)
            Workbooks(n2).Sheets(1).Copy Before:=.Sheets(2)
        End With
        Workbooks(n1).Close
        Workbooks(n2).Close
        MsgBox "���ݸ�������ɣ��������", , "Ad system"
    End If
End Sub

Private Sub ����Ͷ�Ű�ť_Click() '����ҳ���Ͷ������
    If Workbooks(ThisWorkbook.Name).Worksheets.count <> 4 Then '�ж�ǰһ�����Ƿ����
        Exit Sub
    Else
        Call checkstatus
        MsgBox "�����������ɣ�", , "Ad system"
    End If
End Sub

Private Sub �༭��水ť_Click() '�༭���
    If ������.Label17.Caption = "" Or "0" Then '�ж�ǰһ�����Ƿ���ɣ���Ͷ����Ϊ0����δ������һ������
        Exit Sub
    Else
        Call sortrows '����
        Call Circulation '������ѭ��
        MsgBox "�����ѱ༭���" & vbCrLf & "�������������������ļ�", , "Ad system"
    End If
End Sub

Private Sub ���������ļ�_Click() '���������ļ�
    If Workbooks(ThisWorkbook.Name).Worksheets.count = 5 Then '�ж�ǰһ�����Ƿ����
        Call addnewbook
        MsgBox "�����ļ��Ѵ����ɹ���" & vbCrLf & "�����Խ��䵼��Adwords�༭���С�" & vbCrLf & "���β�����ȫ�����", , "Ad system"
    Else
        Exit Sub
    End If
End Sub

Private Sub CB3_Click() '�����ļ���3��Ԥ�������ļ�
    Dim arr As Variant
    Call getimportfilename
    If filename1 = False Then
        name3.Value = ""
    Else
        arr = Split(filename1, "\")
        fn3 = filename1
        name3.Value = arr(UBound(arr))
    End If
End Sub

Private Sub VIPmodulus_Change()
    m1 = CDec(VIPmodulus.Value) 'VIPϵ��
End Sub

Private Sub controlbudget_Click() '����Ԥ��
    n3 = name3.Value '�ļ�����
    d1 = date1.Value '��ǰ����
    b1 = budget1.Value 'ʣ��Ԥ��
    If n3 = "" Or d1 = "" Or b1 = 0 Or m1 = "" Then '�ж�ǰһ�����Ƿ�����
        Exit Sub
    Else
        Workbooks.Open filename:=fn3 '�򿪵����ļ�
        Call yusuansortrows(n3) '����
        Call adcount(n3) '���ü�������������
        Call datedecide(d1) '���ü���ʣ����������
        Call budgetcontrol(b1, m1, n3) '���õ���Ԥ��������
    End If
    MsgBox "Ԥ���ѵ�����ϣ�", , "Ad system"
End Sub

Private Sub �鿴Ԥ��������_Click()
    If n3 = "" Or d1 = "" Or b1 = 0 Or m1 = "" Then '�ж�ǰһ�����Ƿ�����
        Exit Sub
    Else
        Dim rcount As Long
        rcount = Workbooks(n3).Sheets(1).[a65536].End(xlUp).Row
        With ������.ListBox1
            .ColumnCount = 2 '����
            .ColumnHeads = False '�ޱ�����
            .ColumnWidths = "165;120"
            .Column = Application.Transpose(Workbooks(n3).Sheets(1).Range(Cells(1, 1), Cells(rcount, 2)))
        End With
    End If
End Sub

Private Sub �������_Click()
    If n3 = "" Or d1 = "" Or b1 = 0 Or m1 = "" Then '�ж�ǰһ�����Ƿ�����
        Exit Sub
    Else
        Workbooks(n3).SaveAs filename:=ThisWorkbook.Path & "\Ԥ�㵼���ļ�.csv"
        Workbooks("Ԥ�㵼���ļ�.csv").Close True
        MsgBox "Ԥ����������ɣ�" & vbCrLf & "���������Խ��ļ�����adwords�༭���У�", , "Ad system"
        MsgBox "���β�����ȫ����ɣ�", , "Ad system"
    End If
End Sub

Private Sub CB4_Click() '�����ļ���4��pro��༭������ƥ��ʱ
    Dim arr As Variant
    Call getimportfilename
    If filename1 = False Then
        name4.Value = ""
    Else
        arr = Split(filename1, "\")
        fn4 = filename1
        name4.Value = arr(UBound(arr))
    End If
End Sub

Private Sub ��ʼƥ��_Click() 'ƥ��ͻ�״̬��һ��
    Dim n4 As String
    Dim kcount As Long '������������
    Dim bcount As Long
    Dim i As Long
    n4 = name4.Value
    If n4 = "" Or Sheets("PRO���ݴ������").Cells(2, 2) = "" Then '�ж�ǰһ�����Ƿ����
        Exit Sub
    Else
        Workbooks.Open filename:=fn4
        Workbooks(n4).Sheets(1).Columns("b:b").Copy ThisWorkbook.Sheets(1).Columns("k:k")
        Workbooks(n4).Close
'###############################################################################################ƥ������
        With ThisWorkbook.Sheets(1)
            Application.DisplayAlerts = False
            kcount = .[k65536].End(xlUp).Row
            For i = 2 To kcount
                .Cells(i, 12).FormulaArray = "=value(left(k" & i & ",count(1*mid(left(k" & i & ",9),row($1:$9),1))))" 'д������ID�Ĺ�ʽ���������ID��L��
            Next i
            
            .Columns("L:L").Copy
            .Columns("L:L").PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:=False, Transpose:=False 'ѡ����ճ��������ʽ��Ϊ��ֵ
            
            bcount = .[b65536].End(xlUp).Row
            For i = 2 To bcount
                .Cells(i, 13).FormulaArray = "=match(c" & i & ",l:l,0)" '������ͬ�ʽ�������к�
            Next i
            
            
        End With
'################################################################################################ƥ������

        MsgBox "���ݸ�������ɣ��������", , "Ad system"
    End If
End Sub


Private Sub �˳�_Click() '�˳�
    Dim a As Long, i As Long
    Application.DisplayAlerts = False
    a = Worksheets.count
    For i = a - 2 To 1 Step -1 'ɾ�����๤����
        Worksheets(i).Delete
    Next i
    Sheets(1).Cells.Delete '�����һ�β�������
    ������.Hide
    Application.Visible = True
    'ThisWorkbook.Close   ��Ϊʹ�ð�ʱ������һ�д���ע�͵��������д���ȡ��ע�ͼ��ɡ�
End Sub

Private Sub UserForm_QueryClose(Cancel As Integer, CloseMode As Integer) '��ֹ�û�ͨ���ر����Ͻǹرհ�ť�رմ���
    If CloseMode = vbFormControlMenu Then
        MsgBox "��ͨ���˳���ť�رգ�", , "Ad system"
        Cancel = True
   End If
End Sub

