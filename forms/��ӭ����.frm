VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} ��ӭ���� 
   Caption         =   "Ad System"
   ClientHeight    =   5640
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   10365
   OleObjectBlob   =   "��ӭ����.frx":0000
   StartUpPosition =   1  '����������
End
Attribute VB_Name = "��ӭ����"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub UserForm_Initialize()
  time.Caption = "5"
  Call b
End Sub

Private Sub UserForm_QueryClose(Cancel As Integer, CloseMode As Integer) '��ֹ�û�ͨ���ر����Ͻǹرհ�ť�رմ���
    If CloseMode = vbFormControlMenu Then
        MsgBox "�������޷��رմ���", , "Ad system"
        Cancel = True
   End If
End Sub
