start:
	.org 0x00
		ldi r16, 0           ; index = 0
		ldi r17, 4           ; num_words = 4
		ldi ZL, LOW(2*words)   ; Load the low byte of the address of 'words'
		ldi ZH, HIGH(2*words)  ; Load the high byte of the address of 'words'

		lpm r18, Z+             ; Load the word at address Z into r18 (initial max)

	next_word:
		inc r16               ; index++
    
		cpi r16, 4            ; compare index and num_words
		breq done             ; If equal, all words are compared

		lpm r19, Z+             ; Load the next word into r19

		cp r18, r19           ; Compare max with temp
		brlt update_max       ; If max < temp, update max

		rjmp next_word

	update_max:
		mov r18, r19          ; Update the current maximum with the new word
		rjmp next_word        ; Continue to the next word

	done:
		; 'r18' now contains the largest word
		rjmp done

	words: 
		.db 0x05, 0x04, 0x08, 0x03  ; Example binary words
