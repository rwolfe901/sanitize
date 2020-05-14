Public Sub Replace(Source As String, ToReplace As String, ReplaceWith As String, Count As Long = -1, Ret As String)
   
   Dim As Long x, p   
   If Count < 1 Then
      Do
         x = InStr(x + 1, Source,ToReplace)
         If x <> 0 Then
            '' Mid(Source, x, Len(ToReplace)) = ReplaceWith
            Mid(Source, x, Len(ReplaceWith)) = ReplaceWith
            ReplaceWith = Left(ReplaceWith, len(ReplaceWith) - len(Source))
         Else
            Exit do
         EndIf
      Loop
   Else
      Do
         x = InStr(x + 1, Source,ToReplace)
         If x <> 0 Then
            '' Mid(Source, x, Len(ToReplace)) = ReplaceWith
            Mid(Source, x, Len(ToReplace)) = ReplaceWith
            ReplaceWith = Left(ReplaceWith, len(ReplaceWith) - len(Source))
            p += 1
         Else
            Exit do
         EndIf
      Loop Until p = Count
   EndIf
   Ret = Source
End Sub

dim ln as string
dim keys as integer
dim temp as string

print 
print "Log Sanitizer v1.00"
print "Coded in FreeBasic by Robert Wolfe (wolfe.robwolfe@gmail.com)"
print

if command(1) = "" then
  print "Use: "; command(0); " <pattern_file> <source_file> <output_file>"
  print
  end
end if

keys = 0
print "counting search/replace patterns... ";
open command(1) for input as #1
do
  line input #1, temp
  keys = keys + 1
loop until eof(1)
close #1
print keys;" patterns found."

print "loading pattern table... ";
dim searchfor(keys) as string
dim replacewith(keys) as string
dim ptnidx as integer
open command(1) for input as #1
for ptnidx = 1 to keys
  input #1, searchfor(ptnidx), replacewith(ptnidx)
next ptnidx
close #1
print keys;" search/replace patterns loaded."

dim ix2 as integer
dim NewString as string
open command(2) for input as #1
open command(3) for output as #2
while not eof(1)
  line input #1, ln
  for ix2 = 1 to keys
    Replace ln, searchfor(ix2), replacewith(ix2), -1 , NewString
    print #2, NewString
  next ix2
wend
close #1
close #2
