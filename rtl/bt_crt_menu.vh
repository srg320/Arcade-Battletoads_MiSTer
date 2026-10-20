// SPDX-License-Identifier: GPL-3.0-or-later
// Module-scoped constant helpers: deliberately no global include guard.
function automatic integer crt_menu_range_valid(input integer mn,mx,width);
  crt_menu_range_valid=(width==5 || width==7) && mn<=0 && mx>=0 &&
    mn>=-(1<<(width-1)) && mx<(1<<(width-1));
endfunction
function automatic integer crt_menu_bytes(input integer mn,mx,width);
  integer n,a,total;
  begin
    total=1;
    if(crt_menu_range_valid(mn,mx,width)) begin
      for(n=1;n<=mx;n=n+1) total=total+2+((n>=10)?2:1);
      for(n=mn;n<0;n=n+1) begin a=-n;total=total+2+((a>=10)?2:1);end
    end
    crt_menu_bytes=total;
  end
endfunction
function automatic [8191:0] crt_menu_pack(input integer mn,mx,width);
  reg [8191:0] text_value;
  integer n,a;
  begin
    text_value=8192'd0;text_value[7:0]=8'h30;
    if(crt_menu_range_valid(mn,mx,width)) begin
      for(n=1;n<=mx;n=n+1) begin
        text_value={text_value[8183:0],8'h2c};
        text_value={text_value[8183:0],8'h2b};
        if(n>=10) text_value={text_value[8183:0],(8'h30+8'(n/10))};
        text_value={text_value[8183:0],(8'h30+8'(n%10))};
      end
      for(n=mn;n<0;n=n+1) begin
        a=-n;text_value={text_value[8183:0],8'h2c};
        text_value={text_value[8183:0],8'h2d};
        if(a>=10) text_value={text_value[8183:0],(8'h30+8'(a/10))};
        text_value={text_value[8183:0],(8'h30+8'(a%10))};
      end
    end
    crt_menu_pack=text_value;
  end
endfunction
function automatic integer crt_menu_decode(input integer index_value,mn,mx,width);
  begin
    crt_menu_decode=0;
    if(crt_menu_range_valid(mn,mx,width) && index_value>0 && index_value<(1+mx-mn)) begin
      if(index_value<=mx) crt_menu_decode=index_value;
      else crt_menu_decode=mn+(index_value-mx-1);
    end
  end
endfunction
localparam bit CRT_MENU_RANGES_VALID=
  crt_menu_range_valid(CRT_HSIZE_MIN,CRT_HSIZE_MAX,5) &&
  crt_menu_range_valid(CRT_HPOS_MIN,CRT_HPOS_MAX,7) &&
  crt_menu_range_valid(CRT_VPOS_MIN,CRT_VPOS_MAX,5);
localparam integer CRT_HSIZE_OPTION_BYTES=crt_menu_bytes(CRT_HSIZE_MIN,CRT_HSIZE_MAX,5);
localparam integer CRT_HPOS_OPTION_BYTES=crt_menu_bytes(CRT_HPOS_MIN,CRT_HPOS_MAX,7);
localparam integer CRT_VPOS_OPTION_BYTES=crt_menu_bytes(CRT_VPOS_MIN,CRT_VPOS_MAX,5);
localparam [CRT_HSIZE_OPTION_BYTES*8-1:0] CRT_HSIZE_OPTIONS=crt_menu_pack(CRT_HSIZE_MIN,CRT_HSIZE_MAX,5);
localparam [CRT_HPOS_OPTION_BYTES*8-1:0] CRT_HPOS_OPTIONS=crt_menu_pack(CRT_HPOS_MIN,CRT_HPOS_MAX,7);
localparam [CRT_VPOS_OPTION_BYTES*8-1:0] CRT_VPOS_OPTIONS=crt_menu_pack(CRT_VPOS_MIN,CRT_VPOS_MAX,5);
