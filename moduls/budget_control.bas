Attribute VB_Name = "budget_control"
Option Explicit
Dim rcount As Long
Dim g As Long 'gΪ�ܹ������
Dim arr() As Variant
Dim d2 As Long 'ʣ������
Public m1 As Variant

Sub yusuansortrows(n3 As String)  '����
    Dim c As Long
    Workbooks(n3).Sheets(1).Cells.Select
    c = Workbooks(n3).Sheets(1).[a65536].End(xlUp).Row
    With Workbooks(n3).Worksheets(1).Sort
        .SortFields.Clear
        .SortFields.Add Key:=Range(Cells(2, 1), Cells(c, 1)), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
        .SetRange Range(Cells(1, 1), Cells(c, 11))
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
End Sub


Sub adcount(n3 As String) '����������
    Dim i As Long
    With Workbooks(n3).Sheets(1)
         .Columns("b:n").Clear
         .Range("b1") = "Campaign Daily Budget"
         rcount = .[a65536].End(xlUp).Row
         g = rcount - 1 'GΪ�ܹ������
         ReDim arr(2 To rcount)
         For i = 2 To rcount
            arr(i) = Application.WorksheetFunction.CountIf(.Range(Cells(2, 1), Cells(rcount, 1)), .Cells(i, 1))
            '�õ�ÿ�����ϵ���еĹ������
         Next i
         .Range(Cells(2, 2), Cells(rcount, 2)) = Application.WorksheetFunction.Transpose(arr)
         Application.ScreenUpdating = False
         For i = rcount To 2 Step -1
             If .Cells(i, 1) = .Cells(i - 1, 1) Then
                .Range(Cells(i - 1, 1), Cells(i - 1, 2)).Delete 'ɾ����������
             End If
         Next i
         rcount = .[a65536].End(xlUp).Row
         ReDim arr(2 To rcount)
         For i = 2 To rcount
            arr(i) = Cells(i, 2) '��ÿ�����ϵ���еĹ��������������ARR
        Next i
        Range(Cells(2, 2), Cells(rcount, 2)).Clear
    End With
End Sub

Sub datedecide(d1 As String)  '�ж�ʣ������
    Dim xmonth As String
    Dim xday As Long
    Dim days As Long
    xmonth = Mid(d1, 5, 2) '��ǰ�·�
    Select Case xmonth
        Case Is = "02"
            days = 28
        Case Is = "04" Or "06" Or "09" Or "11"
            days = 30
        Case Else
            days = 31
        End Select
    xday = CDec(Mid(d1, 7, 2)) '��ǰ����
    d2 = days - xday 'D2Ϊʣ������
End Sub

Sub budgetcontrol(b1 As Variant, m1 As Variant, n3 As String)   '����Ԥ��������
    Dim i As Long
    For i = 2 To rcount
        arr(i) = b1 / d2 / g * arr(i) '������õ�ÿ�����ϵ�е�Ԥ�㸳��ARR
        With Workbooks(n3).Sheets(1)
            If .Cells(i, 1) Like "*VIP*" Then
               .Cells(i, 2) = Round(arr(i) * CDec(m1), 0)
            Else
               .Cells(i, 2) = Round(arr(i), 0)
            End If
        End With
    Next i
End Sub




