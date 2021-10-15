; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -ppc-asm-full-reg-names -verify-machineinstrs \
; RUN:   -mtriple=powerpc64le-linux-gnu < %s | FileCheck %s

define i64 @f(i64 %a, i64 %b) {
; CHECK-LABEL: f:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sub r5, r3, r4
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    isellt r3, 0, r5
; CHECK-NEXT:    blr
  %c = icmp slt i64 %a, %b
  %d = sub i64 %a, %b
  %e = select i1 %c, i64 0, i64 %d
  ret i64 %e
}

define i64 @g(i64 %a, i64 %b) {
; CHECK-LABEL: g:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sub. r3, r3, r4
; CHECK-NEXT:    isellt r3, 0, r3
; CHECK-NEXT:    blr
  %c = icmp slt i64 %a, %b
  %d = sub nsw i64 %a, %b
  %e = select i1 %c, i64 0, i64 %d
  ret i64 %e
}