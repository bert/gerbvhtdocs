#!/usr/bin/perl

# pads-d2x

# Converts *.rep files to RS274X header format
# Works for the Xilinx ML300 artwork, allegedly created
# by some flavor of PADS
# http://www.xilinx.com/products/boards/ml300/docs/ML300cpu_gerber.zip

# To convert all the RS274D files in that .zip file to a form usable
# by gerbv-0.16,
# for f in *.pho; do (pads-d2x ${f%.pho}.rep; cat $f) >${f%.pho}.gerb; done  

# Status: "Works for me" [TM]  2004-Sep-02
# Larry Doolittle   <ldoolitt(at)recycle(dot)lbl(dot)gov>

@valid_header=(
 "",
 "",
 "Photo-Plotter Apertures Report",
 "==============================",
 "Position  Width  Hgt/ID  Shape    Qty",
 "========  =====  ======  =====    ===");
while (<>) {
	$line++;
	chomp();
	s/\r$//;
	if ($line < 7) {
		die "file has wrong header" if ($_ ne $valid_header[$line-1]);
		next;
	}
	if ($line == 7) {
		print "\%FSLAX35Y35*\%\n";
		print "G04 Aperture Definitions ***\n";
	}
	@A=split();
	SWITCH: {
		if ($A[3] eq ""    ) {                                                                   last SWITCH; }
		if ($A[3] eq "RND" ) { printf("%%ADD%dC,%.4f*%%\n",      $A[0], $A[1]/1000            ); last SWITCH; }
		if ($A[3] eq "RECT") { printf("%%ADD%dR,%.4f,%.4f*%%\n", $A[0], $A[1]/1000, $A[2]/1000); last SWITCH; }
		if ($A[3] eq "SQR" ) { printf("%%ADD%dR,%.4f,%.4f*%%\n", $A[0], $A[1]/1000, $A[1]/1000); last SWITCH; }
		if ($A[3] eq "OVAL") { printf("%%ADD%dO,%.4f,%.4f*%%\n", $A[0], $A[1]/1000, $A[2]/1000); last SWITCH; }
		print "G04 unknown aperture type $A[3]\n";
	}
}
print "G04 Plot Data ***\n"

