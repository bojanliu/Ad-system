Attribute VB_Name = "welcome"
Option Explicit

Sub b()
    Application.OnTime Now + TimeValue("00:00:01"), "a"
End Sub

Sub a()
    ��ӭ����.time.Caption = ��ӭ����.time.Caption - 1
    If ��ӭ����.time.Caption - 1 >= 0 Then
        Call b
    Else
        ��ӭ����.Hide
        ������.Show
    End If
End Sub
