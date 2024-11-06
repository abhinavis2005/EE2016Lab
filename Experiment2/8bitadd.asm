; given two 8-bit binary words(byte) compute the sum and store it in a register
start:
  .cseg
  .org  0x00
  ldi           r16, 0x3
  ldi           r17, 0x5

  add           r16, r17

