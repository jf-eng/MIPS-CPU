// rs = 32'b1101 0010 1111 0001 1010 1100 1011 0000 (32'hD2F1ACB0), rt = 32'b1100 1010 0000 1110 0010 0101 1111 1011 (32'hCA0E25FB)
// outcome of OR op should be: rd = 32'b1101 1010 1111 1111 1010 1101 1111 1011 (32'hDAFFADFB)

.config
	ARCH h
	ASSERT 32'hDAFFADFB

.text
	LW $3 0($0)
    LW $1 4($0)
	OR $2 $3 $1
	JR $0

.data
    #0xD2F1ACB0
    #0xCA0E25FB






    