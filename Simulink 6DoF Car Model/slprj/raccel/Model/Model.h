#ifndef Model_h_
#define Model_h_
#ifndef Model_COMMON_INCLUDES_
#define Model_COMMON_INCLUDES_
#include <stdlib.h>
#include "sl_AsyncioQueue/AsyncioQueueCAPI.h"
#include "rtwtypes.h"
#include "sigstream_rtw.h"
#include "simtarget/slSimTgtSigstreamRTW.h"
#include "simtarget/slSimTgtSlioCoreRTW.h"
#include "simtarget/slSimTgtSlioClientsRTW.h"
#include "simtarget/slSimTgtSlioSdiRTW.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "raccel.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "slexec_parallel.h"
#include "rt_logging_simtarget.h"
#include "rt_nonfinite.h"
#include "math.h"
#include "dt_info.h"
#include "ext_work.h"
#include "blas.h"
#endif
#include "Model_types.h"
#include <string.h>
#include "rtGetInf.h"
#include "rtGetNaN.h"
#include <stddef.h>
#include "rtw_modelmap_simtarget.h"
#include "rt_defines.h"
#include "zero_crossing_types.h"
#define MODEL_NAME Model
#define NSAMPLE_TIMES (5) 
#define NINPUTS (0)       
#define NOUTPUTS (0)     
#define NBLOCKIO (429) 
#define NUM_ZC_EVENTS (1) 
#ifndef NCSTATES
#define NCSTATES (50)   
#elif NCSTATES != 50
#error Invalid specification of NCSTATES defined in compiler command
#endif
#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm) (*rt_dataMapInfoPtr)
#endif
#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val) (rt_dataMapInfoPtr = &val)
#endif
#ifndef IN_RACCEL_MAIN
#endif
typedef struct { real_T needjvu4vj ; } bm2a545cdv ; typedef struct { int8_T
pg1zdxqs4m ; boolean_T ekybzxpjz2 ; } kykmqioigc ; typedef struct { real_T
fzg4v4bzwb ; real_T kdp2bpteqj ; real_T izwfmykdmg ; real_T o4nwybraef ;
real_T ionaytj1hi ; real_T ot0ruhn3ec ; real_T pugnwqsqon ; real_T j03k0bsid4
; real_T fhmqmavvw5 ; real_T kvmm52yte0 ; real_T f4al2st3ta ; real_T
pfkr31kenf ; real_T mgppe3w0fg ; real_T jzqvfuxtym ; real_T mlqwxzdrtd ;
real_T cid3dcdtea ; real_T get5vb1e2d ; boolean_T g3znxgnbb5 ; boolean_T
our5du5hr1 ; } m2bzlhlghr ; typedef struct { real_T muiigb5xri ; real_T
bzrqwbzpb4 ; real_T hrc0vurc1u ; void * dnrshwncok ; void * hxplkrkt2u ;
int32_T ebbd012ewa ; uint32_T k3b0fqaqga ; boolean_T lvqn1qip1a ; int8_T
g54kk2ivts ; int8_T j0jqiw0nyj ; int8_T ilc5d3xbfy ; int8_T mpkqh5re2d ;
int8_T pwf3gdl12m ; int8_T kcmulbg3wy ; uint8_T ni3y0b434e ; boolean_T
l1bcue4ppa ; boolean_T nsdnrronhv ; boolean_T abpsizvzll ; } kje4vbgpbu ;
typedef struct { real_T du0d2svlmy ; } giuxx4bd40 ; typedef struct { real_T
du0d2svlmy ; } c0x20tyv52 ; typedef struct { boolean_T du0d2svlmy ; }
i2qbl2xhzv ; typedef struct { real_T du0d2svlmy ; } np35vopsfg ; typedef
struct { real_T du0d2svlmy ; } j4vt0yed10 ; typedef struct { real_T
du0d2svlmy ; } dkiybvhfva ; typedef struct { m2bzlhlghr lgqwjimiob ; }
dguqa5sjsz ; typedef struct { kje4vbgpbu lgqwjimiob ; } d20odtpm5g ; typedef
struct { giuxx4bd40 lgqwjimiob ; } c13yrcqesf ; typedef struct { c0x20tyv52
lgqwjimiob ; } oqswntawf0 ; typedef struct { i2qbl2xhzv lgqwjimiob ; }
lzafx5bc3d ; typedef struct { np35vopsfg lgqwjimiob ; } nlfnsz4jbi ; typedef
struct { j4vt0yed10 lgqwjimiob ; } ehmqbthobc ; typedef struct { dkiybvhfva
lgqwjimiob ; } mwivi2blve ; typedef struct { real_T ega11xpxic [ 3 ] ; real_T
mt3lyv2dke ; real_T o2nd42dcbc ; real_T dzppqsc04g ; real_T hd0m1sty4c ;
real_T lypsywwdql ; real_T ediqg42n3j ; real_T eoaosvy4po ; real_T e0vh3agpk2
; real_T ljultwvx3r ; real_T l05zepmggl ; real_T b34erucq15 ; real_T
amugc0ynbk [ 2 ] ; real_T pxwixouqhe [ 2 ] ; real_T l1otoog3jz ; real_T
h04burdemz ; real_T gs2lwb03pq ; real_T ndkwerwcuj ; real_T c3n5ntdbcb ;
real_T ngsnipojdi ; real_T g50nquwiuh ; real_T ezfviqmxce ; real_T bkwxlw0wjw
; real_T fpv1uaqdmk ; real_T bptxnepez0 ; real_T li0vjxh4lt ; real_T
l5pvziepx3 ; real_T lvbwp21bcl ; real_T p42i4dgtis ; real_T hglyt0kpm2 ;
real_T kbyhnksaml ; real_T khqmsyhcdb ; real_T nfeq1dd5lz ; real_T hvk5imnlsc
; real_T oeqm2oypnl ; real_T ok14bc0gqv ; real_T fpf1wo4mtw ; real_T
ir1zlpliou ; real_T jggj5dry5y ; real_T dsw2veynvo ; real_T amhcdzxxks ;
real_T jweaxsqco2 ; real_T bnyapv3vad ; real_T ahf14xi1fk ; real_T mmcf12ll20
; real_T p4bu3dj1sr ; real_T cijrn5hbnv ; real_T h4wiazhtvz ; real_T
pzel3x00n1 [ 8 ] ; real_T c1wn45myag ; real_T lfexvogcny ; real_T fwjapkcrgo
; real_T axzhla2nkv ; real_T jovls20zhs ; real_T a2bxxl4hbb ; real_T
jjloyle3hk ; real_T c0xhavjdt2 ; real_T mgiumib5h4 ; real_T adchq4mqkt ;
real_T em0jfsw10j ; real_T fafkwxl1sr ; real_T l21ame21te ; real_T pjoud41a1f
; real_T myypyvd2il ; real_T fjn0tkmr5w ; real_T cdvcps5b3u ; real_T
nvuznpptst ; real_T i0fmnfhozl ; real_T oedunmj2xq ; real_T ahashvzyly ;
real_T odazlr1up0 ; real_T ph4mpojtp3 ; real_T cdekyl1gvq ; real_T hivo2zq5zu
; real_T p5mm1rqiht ; real_T c1prvgd2my ; real_T anzqdc4l14 ; real_T
huxjbcvglm ; real_T a0rhlxsm00 ; real_T nw0mvpivty ; real_T d2ovrnfxki ;
real_T aknzqdxnri ; real_T gaktijxane ; real_T gf5ktnuaim ; real_T lrnbheyva5
; } mgyyz1jkll ; typedef struct { real_T pvjhi3gso2 [ 3 ] ; real_T eonpu2pzrq
[ 3 ] ; real_T e5yawxd1j2 [ 3 ] ; real_T hfxjvwh0u5 [ 3 ] ; real_T k3f1nmgjls
[ 4 ] ; real_T mapyulasb3 [ 3 ] ; real_T inu4wg3gkf ; real_T cl2x5nwgfv ;
real_T hqwenfc21o ; real_T m3vmvpj3ot ; real_T br3uuhw3mi ; real_T ifko42xofi
; real_T ghrwv4d402 [ 3 ] ; real_T bpl3444wrc [ 3 ] ; real_T okxkyrq2js [ 3 ]
; real_T gt22hfzcl1 ; real_T enut0kaogg ; real_T d2ujoty01h ; real_T
cbrd20uurz ; real_T er4vlcpwbi ; real_T bgi052y3br ; real_T hvp1gradwz [ 3 ]
; real_T nvjb1zyeot [ 3 ] ; real_T g1t0guecqc ; real_T eqvjmsguid ; real_T
o32plelcvd ; real_T enypiuwsb2 ; real_T nbktpp0lvg ; real_T hinsfhp2dr ;
real_T k4weon4f5m [ 3 ] ; real_T mw2nodpda2 [ 3 ] ; real_T o3e0i34poo ;
real_T ousopy1tw2 ; real_T hexx0034mu ; real_T kfme0qbiru ; real_T md5cgoknb4
; real_T eqvtpko42o ; real_T jf0zpbcmly [ 3 ] ; real_T bmmfunwslz [ 3 ] ;
real_T myorl52jnj [ 4 ] ; real_T nth32z51hj [ 8 ] ; real_T cfvprygh5m ;
real_T myxoa4skdj ; real_T nt2ryilz5c ; real_T hbj0g2qx41 ; real_T gqo2weaylc
; real_T efr5csvtgc ; real_T hvemaufdzy ; real_T oyeefute3n ; real_T
k030h031nf ; real_T nvbpb0fbqt ; real_T iisxvwtmm2 ; real_T bqidvpwhxi ;
real_T axsxbymdx3 ; real_T fvowvm54bi ; real_T lzqcktyc0f ; real_T ddateqty1m
; real_T e0msuhqurx [ 2 ] ; real_T extij4nz5j ; real_T oz0mcdshb0 ; real_T
pqjxrmmbat ; real_T cris3zhr4s [ 2 ] ; real_T m3hstgkwc5 ; real_T oba0asmstv
; real_T pd5ztsknbz [ 4 ] ; real_T b1iayfkcgr [ 4 ] ; real_T h5gyggntv0 [ 4 ]
; real_T g0qyryf22t [ 4 ] ; real_T ewcbi1oba5 [ 4 ] ; real_T ldkm0ugudz [ 3 ]
; real_T ozdtzbgkdf [ 3 ] ; real_T ceczdiyylj [ 9 ] ; real_T ecf2qd5ow1 [ 3 ]
; real_T p0b3gh0cse [ 3 ] ; real_T oia1zvoodo [ 3 ] ; real_T oappmecbv2 [ 3 ]
; real_T eu2t41mxrx [ 3 ] ; real_T prefah5pzr [ 3 ] ; real_T efk4s0oolc [ 3 ]
; real_T ftvqe0uh13 ; real_T idbx2v5ps4 ; real_T al0pbuhcyj [ 6 ] ; real_T
d1dcbrujn4 [ 6 ] ; real_T gzifpcqg5d [ 6 ] ; real_T pd1oti1plh [ 3 ] ; real_T
nqiffs1hlu [ 8 ] ; real_T bqubxxxv14 [ 12 ] ; real_T bnwfgokmmt [ 4 ] ;
real_T n0r4vtjekz [ 4 ] ; real_T plzzxupveq [ 4 ] ; real_T el52g0n13h [ 3 ] ;
real_T c15chslzvc [ 3 ] ; real_T dlgwil20qx [ 3 ] ; real_T g5yrwwvkv1 [ 3 ] ;
real_T gv4ljvygnc [ 3 ] ; real_T jfpjqjbnfk ; real_T aldrwqfxb5 ; real_T
kvvvha14yc ; real_T ngtjbxcnqu ; real_T ay0ay2voln ; real_T ensg1nkiqt ;
real_T dtpwdh1voh [ 3 ] ; real_T c5pc1vmllo [ 3 ] ; real_T i0vpl0gksi [ 3 ] ;
real_T mmtmwbyyhg [ 3 ] ; real_T kp1v5n4k2y [ 9 ] ; real_T mjbl2dr5ua [ 3 ] ;
real_T kd5rxz3n4m ; real_T mimfibnxwe ; real_T p2gyzduiig ; real_T k4p4h5u04r
; real_T ipemmxxmhr ; real_T jxhhmegcan ; real_T k0ebpoiqkg ; real_T
fl40zleksa ; real_T al152hkt20 ; real_T oexjeoh0kn [ 2 ] ; real_T pkre1q5ccp
[ 2 ] ; real_T lve105k41a ; real_T o3jujmlget ; real_T kgjdjym33q ; real_T
cdgznlmrzw ; real_T o3ekgqmtty ; real_T fhxl0z4jn0 ; real_T doaf1eebn2 ;
real_T bweity5rg3 ; real_T f5m0tkgk4u ; real_T o4ll2g351p ; real_T grbc2stsl0
; real_T glqtquwrw3 ; real_T e5m4rkfscq ; real_T pwcwi0alqf ; real_T
l3vdrko1xz ; real_T ovbsf0smul ; real_T mbwe5nwyiz ; real_T bguvxvujpl ;
real_T kx5mq1a1ng [ 2 ] ; real_T aaq3hskxlr [ 4 ] ; real_T o4ytosv2yj [ 4 ] ;
real_T kbkrhbh10c [ 4 ] ; real_T iusccz1j4q [ 4 ] ; real_T egjymoiv5o [ 4 ] ;
real_T garjoqrobb [ 4 ] ; real_T j4i2i1skgv [ 4 ] ; real_T pzkudpj4th [ 4 ] ;
real_T mkmnzijy1o [ 4 ] ; real_T i3mwv3ggy2 [ 4 ] ; real_T cj4lu3qex5 [ 4 ] ;
real_T jvrjdv0gt2 [ 4 ] ; real_T dp2x55ypuh [ 4 ] ; real_T ev2nfkeyjo [ 4 ] ;
real_T an2kcxrem4 [ 4 ] ; real_T k4jplumuyp [ 4 ] ; real_T dlh1z2zci5 [ 4 ] ;
real_T hnkpbw0wov [ 4 ] ; real_T f1qb1hnz3i [ 4 ] ; real_T hz54hbyemh [ 12 ]
; real_T l1evogaaxo [ 4 ] ; real_T agt5xhqmf3 [ 4 ] ; real_T b3ad5onoa2 [ 4 ]
; real_T f4vukswwlg [ 4 ] ; real_T bpprb5ntmd [ 4 ] ; real_T aisb5lyqpj [ 4 ]
; real_T bnbg2hntde [ 4 ] ; real_T p1bqupwwiw [ 4 ] ; real_T k4slvi523r [ 4 ]
; real_T esa1rq1xoq [ 4 ] ; real_T flkpa5hjuv [ 4 ] ; real_T ljyorje2ji [ 4 ]
; real_T bc5sajmswo [ 4 ] ; real_T cnug3c1shv [ 4 ] ; real_T jru5adg1p2 [ 4 ]
; real_T gdk10y22mg [ 4 ] ; real_T f0mlqnkazj [ 4 ] ; real_T c50lgcraik [ 4 ]
; real_T c4ul0d30bq [ 4 ] ; real_T esxbjo5rfs [ 4 ] ; real_T jei4iuevnd [ 4 ]
; real_T ht2jvdobfx [ 4 ] ; real_T pnqzy35tae [ 4 ] ; real_T dxmdwb0cac [ 4 ]
; real_T ff3mliat0s [ 4 ] ; real_T fx5ty00crh [ 4 ] ; real_T burfuqcff1 [ 4 ]
; real_T obnarmvehq [ 4 ] ; real_T iql32m0ypo [ 4 ] ; real_T hv122mnogo [ 4 ]
; real_T dgmzmjtoih [ 4 ] ; real_T ipnesjdtwm [ 4 ] ; real_T fvxvkgre4w [ 4 ]
; real_T l4nqaq2c1p [ 4 ] ; real_T kxch15zhkk [ 4 ] ; real_T oz2d10hqkl [ 4 ]
; real_T otjy4we14b [ 4 ] ; real_T lgubl0fdy2 [ 4 ] ; real_T m1qjkcw32m [ 4 ]
; real_T ecy2pr0mzx [ 4 ] ; real_T hkypdod5l3 [ 4 ] ; real_T mkpc0lab23 [ 4 ]
; real_T arwssyvqck [ 3 ] ; real_T i0u010obrq [ 9 ] ; real_T fpymxddbs2 [ 3 ]
; real_T musliantq1 ; real_T lbewm2jsx1 ; real_T l2s0tqh3te ; real_T
iriit3n5bo ; real_T cd2hroncxm ; real_T jzuucjp0dz ; real_T mungqcmpvi [ 3 ]
; real_T df3a24nxgi [ 9 ] ; real_T gm1wafv4ux [ 3 ] ; real_T avxpohsdpu [ 4 ]
; real_T cpjz3g40yo ; real_T lumd2qzswa [ 4 ] ; real_T dti3f2mbo5 ; real_T
ofoyzad0qy ; real_T lpuzvoki4l ; real_T lwmye31lm3 ; real_T kfnovxlgtm ;
real_T elx424ncss ; real_T ndzkyesiln ; real_T g3f35gdt3z [ 4 ] ; real_T
k53ri4b13w ; real_T krdblgex4s ; real_T kvdpteykgw ; real_T jdgn4cp0cr ;
real_T mzz0ezlzdx ; real_T dxsdjkqicv ; real_T nitv3ooaid ; real_T p2gpdkhmex
[ 4 ] ; real_T omist3fzp5 ; real_T c0u4csx3fv ; real_T f2msdtbamo [ 3 ] ;
real_T hvwbnq1lmh [ 4 ] ; real_T egcghkzrir [ 4 ] ; real_T mzkwwpss3u [ 4 ] ;
real_T bzgmcfjntk [ 3 ] ; real_T a4e2na1xrj [ 3 ] ; real_T bfswimvzqn [ 3 ] ;
real_T lpl4gfsgpc [ 3 ] ; real_T l5cmmu0mfq [ 9 ] ; real_T jsfwkegsvm [ 3 ] ;
real_T miox5ugopx [ 8 ] ; real_T fxn4hwoc2i ; real_T h0nyvmdejr ; real_T
jtmoolkjyi [ 2 ] ; real_T c1qcc3keu0 ; real_T ew0tdzejaw ; real_T jgrlwz0emm
; real_T mianffndr0 ; real_T bsfchtjtbj ; real_T hd50erlqk4 ; real_T
lwsi3mbjjr [ 2 ] ; real_T ffzywqhgth [ 4 ] ; real_T ixahpfbqkq [ 4 ] ; real_T
mbcdjmj54o [ 4 ] ; real_T mljhld5dxz [ 108 ] ; real_T ooa4chzyum ; real_T
n2cddoxzwg [ 4 ] ; real_T gj5z2iross [ 8 ] ; real_T em5brxpqgm [ 3 ] ; real_T
f1cnc05vms [ 3 ] ; real_T htaqt01foc [ 4 ] ; real_T c3nepxie4q ; real_T
ktlnuv14xq [ 9 ] ; real_T gb53a3kvqb [ 3 ] ; real_T f1m4urt4hd [ 3 ] ; real_T
baxaby202f [ 4 ] ; real_T b1vgcfjvga [ 12 ] ; real_T ntmx4shpi3 [ 4 ] ;
real_T lwvhqqex0u [ 12 ] ; real_T nsdx0z0fdx [ 3 ] ; real_T m5m2qoc5iw [ 4 ]
; real_T hqueo1nq2e ; real_T hnkqyjlwrd [ 32 ] ; real_T cmzqeqee30 [ 4 ] ;
real_T g0hhdb2fh5 [ 4 ] ; real_T kochremxdv [ 4 ] ; real_T le0gl2m1lj [ 4 ] ;
real_T ffigzhjzcw ; real_T nun3vg2blr ; real_T bk252kmhzu ; real_T fvugwfgfc0
; real_T pnqaqfhm5j ; real_T cdvhvjbi3x [ 4 ] ; real_T moac0guhpm ; real_T
fuk2whiqqw ; real_T adfxhy5k0u ; real_T bj34u5bdc4 ; real_T kh1ejfn54y ;
real_T mztqppqqmq ; real_T elhlhe03kq ; real_T bswnq24mn4 ; real_T dq4rsrfstk
; real_T hbrpbs4330 ; real_T aw5bam55tj [ 16 ] ; real_T jna2ldaqwh [ 4 ] ;
real_T bui5cajeyn ; real_T boo33qsxey [ 4 ] ; boolean_T axu4jgrmk2 [ 2 ] ;
boolean_T k0ra04c3s3 ; boolean_T eyosgetzu1 ; boolean_T faz1qe4gr4 ;
boolean_T al2rogaqs5 ; boolean_T hufn0fr353 ; boolean_T cvyj00103j ;
mgyyz1jkll gkgoch4i20 [ 4 ] ; dguqa5sjsz fujf10vfd2 [ 4 ] ; bm2a545cdv
c5nsirmoeg ; bm2a545cdv ivr0vxwdxm ; bm2a545cdv cman0zlcfck ; } B ; typedef
struct { real_T k2m5zl3m3k [ 2 ] ; real_T n5fe15tlck ; real_T awunvg0cnh ;
real_T dx1fdgtesf ; real_T m1qp52cqky ; real_T anevwupbcq ; real_T dimpwebbfq
[ 3 ] ; volatile real_T hwbajfhqup [ 3 ] ; volatile real_T mntyqwxfjm [ 3 ] ;
volatile real_T bxavz5ufk2 [ 3 ] ; volatile real_T dme1ph5qgn [ 4 ] ;
volatile real_T hqllcojfb4 [ 3 ] ; volatile real_T iq1lkigcxm [ 2 ] ;
volatile real_T ckvuwlhl0x [ 8 ] ; real_T e5vvl2gul3 ; real_T dh4jx1mjpn [ 2
] ; real_T bytt2ctgen [ 9 ] ; struct { void * AQHandles ; } aq2mpmltq0 ;
int32_T moca11x12g ; int32_T debzszrka4 ; int32_T brfzaqsrdh ; int32_T
fwxgq21t2k ; int32_T m4e3e0josj ; int32_T kzy2wc0fue ; int32_T guh5vo03zz ;
int_T mfqj40hrza ; int_T nc30geqzj5 ; int_T flujkqdezc [ 4 ] ; int_T
osol1uyisn [ 4 ] ; int8_T miqxwdf310 ; volatile int8_T cxmfeqly1b ; volatile
int8_T nede5duig5 ; volatile int8_T o5ics2iabk ; volatile int8_T joc1mpntor ;
volatile int8_T prlp0sdren ; volatile int8_T djxulpnosq ; volatile int8_T
ha2w00udvs ; int8_T jnio4myedw ; boolean_T nw1voagdka ; boolean_T palzix4p11
; boolean_T ogutke5kay ; boolean_T jozbo3aidm ; boolean_T ovsorff0ds ;
boolean_T a3l4wmvruy ; boolean_T h3or5uadol ; boolean_T i4rhuztuun ;
d20odtpm5g fujf10vfd2 [ 4 ] ; kykmqioigc c5nsirmoeg ; kykmqioigc ivr0vxwdxm ;
kykmqioigc cman0zlcfck ; } DW ; typedef struct { real_T ilyaz24f0q [ 3 ] ;
real_T nwnt24siu5 [ 3 ] ; real_T mjveg013jc ; real_T psmp4obowi [ 4 ] ;
real_T bpzzt043mm [ 4 ] ; real_T dthwa4i4cl [ 3 ] ; real_T putzngjs5d [ 3 ] ;
real_T luvhyvw2b4 ; real_T dxpvyjrd3t ; real_T fzkq5qdmqm ; real_T mvqligivge
; real_T ncuneaejga ; real_T o5zuq2k1hh ; real_T npdx5gi1mb [ 4 ] ; real_T
abtm4cavv1 [ 8 ] ; real_T dm212ksklg [ 4 ] ; real_T isgw2rk1tp [ 3 ] ;
c13yrcqesf fujf10vfd2 [ 4 ] ; } X ; typedef int_T PeriodicIndX [ 3 ] ;
typedef real_T PeriodicRngX [ 6 ] ; typedef struct { real_T ilyaz24f0q [ 3 ]
; real_T nwnt24siu5 [ 3 ] ; real_T mjveg013jc ; real_T psmp4obowi [ 4 ] ;
real_T bpzzt043mm [ 4 ] ; real_T dthwa4i4cl [ 3 ] ; real_T putzngjs5d [ 3 ] ;
real_T luvhyvw2b4 ; real_T dxpvyjrd3t ; real_T fzkq5qdmqm ; real_T mvqligivge
; real_T ncuneaejga ; real_T o5zuq2k1hh ; real_T npdx5gi1mb [ 4 ] ; real_T
abtm4cavv1 [ 8 ] ; real_T dm212ksklg [ 4 ] ; real_T isgw2rk1tp [ 3 ] ;
oqswntawf0 fujf10vfd2 [ 4 ] ; } XDot ; typedef struct { boolean_T ilyaz24f0q
[ 3 ] ; boolean_T nwnt24siu5 [ 3 ] ; boolean_T mjveg013jc ; boolean_T
psmp4obowi [ 4 ] ; boolean_T bpzzt043mm [ 4 ] ; boolean_T dthwa4i4cl [ 3 ] ;
boolean_T putzngjs5d [ 3 ] ; boolean_T luvhyvw2b4 ; boolean_T dxpvyjrd3t ;
boolean_T fzkq5qdmqm ; boolean_T mvqligivge ; boolean_T ncuneaejga ;
boolean_T o5zuq2k1hh ; boolean_T npdx5gi1mb [ 4 ] ; boolean_T abtm4cavv1 [ 8
] ; boolean_T dm212ksklg [ 4 ] ; boolean_T isgw2rk1tp [ 3 ] ; lzafx5bc3d
fujf10vfd2 [ 4 ] ; } XDis ; typedef struct { real_T ilyaz24f0q [ 3 ] ; real_T
nwnt24siu5 [ 3 ] ; real_T mjveg013jc ; real_T psmp4obowi [ 4 ] ; real_T
bpzzt043mm [ 4 ] ; real_T dthwa4i4cl [ 3 ] ; real_T putzngjs5d [ 3 ] ; real_T
luvhyvw2b4 ; real_T dxpvyjrd3t ; real_T fzkq5qdmqm ; real_T mvqligivge ;
real_T ncuneaejga ; real_T o5zuq2k1hh ; real_T npdx5gi1mb [ 4 ] ; real_T
abtm4cavv1 [ 8 ] ; real_T dm212ksklg [ 4 ] ; real_T isgw2rk1tp [ 3 ] ;
nlfnsz4jbi fujf10vfd2 [ 4 ] ; } CStateAbsTol ; typedef struct { real_T
ilyaz24f0q [ 3 ] ; real_T nwnt24siu5 [ 3 ] ; real_T mjveg013jc ; real_T
psmp4obowi [ 4 ] ; real_T bpzzt043mm [ 4 ] ; real_T dthwa4i4cl [ 3 ] ; real_T
putzngjs5d [ 3 ] ; real_T luvhyvw2b4 ; real_T dxpvyjrd3t ; real_T fzkq5qdmqm
; real_T mvqligivge ; real_T ncuneaejga ; real_T o5zuq2k1hh ; real_T
npdx5gi1mb [ 4 ] ; real_T abtm4cavv1 [ 8 ] ; real_T dm212ksklg [ 4 ] ; real_T
isgw2rk1tp [ 3 ] ; ehmqbthobc fujf10vfd2 [ 4 ] ; } CXPtMin ; typedef struct {
real_T ilyaz24f0q [ 3 ] ; real_T nwnt24siu5 [ 3 ] ; real_T mjveg013jc ;
real_T psmp4obowi [ 4 ] ; real_T bpzzt043mm [ 4 ] ; real_T dthwa4i4cl [ 3 ] ;
real_T putzngjs5d [ 3 ] ; real_T luvhyvw2b4 ; real_T dxpvyjrd3t ; real_T
fzkq5qdmqm ; real_T mvqligivge ; real_T ncuneaejga ; real_T o5zuq2k1hh ;
real_T npdx5gi1mb [ 4 ] ; real_T abtm4cavv1 [ 8 ] ; real_T dm212ksklg [ 4 ] ;
real_T isgw2rk1tp [ 3 ] ; mwivi2blve fujf10vfd2 [ 4 ] ; } CXPtMax ; typedef
struct { real_T e1vdkcrpj3 ; real_T jztkbbrcp3 ; real_T hvs1owvcug ; real_T
dzj0j0ohm2 ; real_T n0i1qrycyp ; real_T hvvozr23ie [ 4 ] ; real_T brojvngajw
[ 4 ] ; real_T dsw3wuopdq ; } ZCV ; typedef struct { ZCSigState pgeh2dpc5w ;
} PrevZCX ; typedef struct { rtwCAPI_ModelMappingInfo mmi ; } DataMapInfo ;
struct ikjp2x302z_ { real_T Constant_Value ; real_T Constant_Value_p0urwfcsp0
; real_T Constant1_Value ; real_T Constant2_Value ; real_T u_Gain ; boolean_T
yn_Y0 ; boolean_T yn_Y0_avhfjm4x2r ; boolean_T UnitDelay_InitialCondition ;
boolean_T CombinatorialLogic_table [ 8 ] ; } ; struct cw4bvjax0v_ { real_T
Clutch_OmegaTol ; ikjp2x302z lgqwjimiob ; } ; struct btuihsyghq_ { real_T
SelectCamberHeightSlope_AxleNums [ 2 ] ; real_T
SelectCamberSteeringCenter_AxleNums [ 2 ] ; real_T
SelectCamberSteeringSlope_AxleNums ; real_T SelectCasterHeightSlope_AxleNums
[ 2 ] ; real_T SelectCasterSteeringCenter_AxleNums [ 2 ] ; real_T
SelectCasterSteeringSlope_AxleNums ; real_T SelectRollSteerSlope_AxleNums [ 2
] ; real_T SelectToeSteeringCenter_AxleNums [ 2 ] ; real_T
SelectToeSteeringSlope_AxleNums ; real_T
Constrainedspringdampercombination_AxleNums [ 2 ] ; real_T
SteeringHeightSlopeBySteeredAxle_AxleNums ; real_T Gain5_Gain ; real_T
Gain4_Gain ; real_T Saturation_UpperSat ; real_T Saturation_LowerSat ; real_T
Gain_Gain ; real_T LowerHardStopBlendMult_tableData [ 3 ] ; real_T
LowerHardStopBlendMult_bp01Data [ 3 ] ; real_T Constant_Value ; real_T
Gain5_Gain_jkxoakmxpu ; real_T Gain4_Gain_irkyjhh3iw ; real_T
Saturation_UpperSat_n4aw3icftg ; real_T Saturation_LowerSat_k0nt0to2jq ;
real_T Gain_Gain_hiz1i5vapd ; real_T UpperHardStopBlendMult_tableData [ 3 ] ;
real_T UpperHardStopBlendMult_bp01Data [ 3 ] ; real_T
Constant_Value_cxh1c5u1d3 ; real_T HeightSignConvention_Gain ; real_T
Gain_Gain_jvgldouiuy ; real_T Gain_Gain_ccuizykiq5 ; real_T
VehicleForceSign_Gain ; real_T Signconvention_Gain ; real_T
Constant_Value_jm5jx31jcv ; real_T VehicleVehicleWheelOffset1_Value [ 2 ] ;
real_T Constant_Value_iptongm5vx ; real_T VehicleVehicleWheelOffset3_Value [
2 ] ; real_T Constant_Value_j3m5zpkqvc ; real_T
VehicleVehicleWheelOffset3_Value_i0vcxju0dq [ 2 ] ; real_T
Constant_Value_p5zpth4tum ; real_T
VehicleVehicleWheelOffset3_Value_i1utw51xb4 [ 3 ] ; } ; struct P_ { real_T
brakePadMeanRadius ; real_T camber ; real_T cgToFrontAxle ; real_T
cgToRearAxle ; real_T cgVerticalToAxlePlane ; real_T cornerStiffness ; real_T
discBrakeActuatorBore ; real_T kineticFriction ; real_T lammux ; real_T
lammuy ; real_T longDragArea ; real_T longDragCoeff ; real_T longLiftCoeff ;
real_T mass ; real_T maxBrakePressure ; real_T numBrakePads ; real_T
staticFriction ; real_T tirePressure ; real_T trackWidth ; real_T
wheelAngleLimit ; real_T wheelBase ; real_T yawPolarInertia ; real_T
CombinedSlipWheel2DOF_ALPMAX ; real_T CombinedSlipWheel2DOF_ALPMIN ; real_T
CombinedSlipWheel2DOF_ASPECT_RATIO ; real_T
IndependentSuspensionDoubleWishbone_AxleNumVec [ 4 ] ; real_T
CombinedSlipWheel2DOF_CAMMAX ; real_T CombinedSlipWheel2DOF_CAMMIN ; real_T
IndependentSuspensionDoubleWishbone_Camber ; real_T
IndependentSuspensionDoubleWishbone_CamberHslp ; real_T
IndependentSuspensionDoubleWishbone_CamberStrgSlp ; real_T
IndependentSuspensionDoubleWishbone_Caster ; real_T
IndependentSuspensionDoubleWishbone_CasterHslp ; real_T
IndependentSuspensionDoubleWishbone_CasterStrgSlp ; real_T
VehicleBody6DOF_Cpm ; real_T VehicleBody6DOF_Cs [ 11 ] ; real_T
VehicleBody6DOF_Cym [ 11 ] ; real_T IndependentSuspensionDoubleWishbone_Cz ;
real_T KinematicSteering_Db ; real_T IndependentSuspensionDoubleWishbone_F0z
; real_T CombinedSlipWheel2DOF_FNOMIN ; real_T CombinedSlipWheel2DOF_FZMAX ;
real_T CombinedSlipWheel2DOF_FZMIN ; real_T CombinedSlipWheel2DOF_GRAVITY ;
real_T IndependentSuspensionDoubleWishbone_Hmax ; real_T SignalHold_IC ;
real_T SignalHold_IC_ha5pwu4h2j ; real_T SignalHold_IC_g0qec3hyrf ; real_T
CombinedSlipWheel2DOF_IYY ; real_T VehicleBody6DOF_Iveh [ 9 ] ; real_T
CombinedSlipWheel2DOF_KPUMAX ; real_T CombinedSlipWheel2DOF_KPUMIN ; real_T
PredictiveDriver_Kaw ; real_T PredictiveDriver_Kff ; real_T
PredictiveDriver_Kg ; real_T PredictiveDriver_Ki ; real_T PredictiveDriver_Kp
; real_T IndependentSuspensionDoubleWishbone_Kz ; real_T PredictiveDriver_L ;
real_T CombinedSlipWheel2DOF_LONGVL ; real_T CombinedSlipWheel2DOF_MASS ;
real_T CombinedSlipWheel2DOF_NOMPRES ; real_T CombinedSlipWheel2DOF_PRESMAX ;
real_T CombinedSlipWheel2DOF_PRESMIN ; real_T VehicleBody6DOF_Pabs ; real_T
KinematicSteering_PctAck ; real_T DragForce_R ; real_T
CombinedSlipWheel2DOF_RIM_RADIUS ; real_T
IndependentSuspensionDoubleWishbone_RollStrgSlp ; real_T
IndependentSuspensionDoubleWishbone_StrgHgtSlp ; real_T
KinematicSteering_StrgRatio ; real_T VehicleBody6DOF_Tair ; real_T
IndependentSuspensionDoubleWishbone_Toe ; real_T
IndependentSuspensionDoubleWishbone_ToeStrgSlp ; real_T
CombinedSlipWheel2DOF_UNLOADED_RADIUS ; real_T
CombinedSlipWheel2DOF_VERTICAL_DAMPING ; real_T CombinedSlipWheel2DOF_VXLOW ;
real_T CombinedSlipWheel2DOF_WIDTH ; real_T
IndependentSuspensionDoubleWishbone_WhlNumVec [ 4 ] ; real_T
VehicleBody6DOF_Xe_o [ 3 ] ; real_T VehicleBody6DOF_beta_w [ 11 ] ; real_T
CombinedSlipWheel2DOF_br ; real_T CompareToConstant_const ; real_T
VehicleBody6DOF_d ; real_T VehicleBody6DOF_eul_o [ 3 ] ; real_T
VehicleBody6DOF_g ; real_T VehicleBody6DOF_latOff ; real_T
VehicleBody6DOF_longOff ; real_T CombinedSlipWheel2DOF_omegao ; real_T
VehicleBody6DOF_p_o [ 3 ] ; real_T PredictiveDriver_tau ; real_T
PredictiveDriver_tauerr ; real_T div0protectabspoly_thresh ; real_T
div0protectabspoly3_thresh ; real_T VehicleXYPlotter_tireFNorm ; real_T
CombinedSlipWheel2DOF_turnslip ; real_T VehicleXYPlotter_velNorm ; real_T
VehicleBody6DOF_vertOff ; real_T PredictiveDriver_vnom ; real_T
VehicleBody6DOF_w [ 2 ] ; real_T VehicleBody6DOF_xbdot_o [ 3 ] ; real_T
VehicleBody6DOF_z1I [ 9 ] ; real_T VehicleBody6DOF_z1R [ 3 ] ; real_T
VehicleBody6DOF_z1m ; real_T VehicleBody6DOF_z2I [ 9 ] ; real_T
VehicleBody6DOF_z2R [ 3 ] ; real_T VehicleBody6DOF_z2m ; real_T
VehicleBody6DOF_z3I [ 9 ] ; real_T VehicleBody6DOF_z3R [ 3 ] ; real_T
VehicleBody6DOF_z3m ; real_T VehicleBody6DOF_z4I [ 9 ] ; real_T
VehicleBody6DOF_z4R [ 3 ] ; real_T VehicleBody6DOF_z4m ; real_T
VehicleBody6DOF_z5I [ 9 ] ; real_T VehicleBody6DOF_z5R [ 3 ] ; real_T
VehicleBody6DOF_z5m ; real_T VehicleBody6DOF_z6I [ 9 ] ; real_T
VehicleBody6DOF_z6R [ 3 ] ; real_T VehicleBody6DOF_z6m ; real_T
VehicleBody6DOF_z7I [ 9 ] ; real_T VehicleBody6DOF_z7R [ 3 ] ; real_T
VehicleBody6DOF_z7m ; real_T CombinedSlipWheel2DOF_zdoto ; real_T
CombinedSlipWheel2DOF_zo ; real_T Gain2_Gain ; real_T Out1_Y0 ; real_T
UnitDelay_InitialCondition ; real_T Constant_Value ; real_T u1_UpperSat ;
real_T u1_LowerSat ; real_T u1_UpperSat_ktphrh25ym ; real_T
u1_LowerSat_kyjd4o3lsn ; real_T u0_UpperSat ; real_T u0_LowerSat ; real_T
MagicTireConstInput_BOTTOM_OFFST ; real_T MagicTireConstInput_BOTTOM_STIFF ;
real_T MagicTireConstInput_BREFF ; real_T MagicTireConstInput_DREFF ; real_T
MagicTireConstInput_FREFF ; real_T MagicTireConstInput_LATERAL_STIFFNESS ;
real_T MagicTireConstInput_LONGITUDINAL_STIFFNESS ; real_T
MagicTireConstInput_PCFX1 ; real_T MagicTireConstInput_PCFX2 ; real_T
MagicTireConstInput_PCFX3 ; real_T MagicTireConstInput_PCFY1 ; real_T
MagicTireConstInput_PCFY2 ; real_T MagicTireConstInput_PCFY3 ; real_T
MagicTireConstInput_PCX1 ; real_T MagicTireConstInput_PCY1 ; real_T
MagicTireConstInput_PDX1 ; real_T MagicTireConstInput_PDX2 ; real_T
MagicTireConstInput_PDX3 ; real_T MagicTireConstInput_PDXP1 ; real_T
MagicTireConstInput_PDXP2 ; real_T MagicTireConstInput_PDXP3 ; real_T
MagicTireConstInput_PDY1 ; real_T MagicTireConstInput_PDY2 ; real_T
MagicTireConstInput_PDY3 ; real_T MagicTireConstInput_PDYP1 ; real_T
MagicTireConstInput_PDYP2 ; real_T MagicTireConstInput_PDYP3 ; real_T
MagicTireConstInput_PDYP4 ; real_T MagicTireConstInput_PECP1 ; real_T
MagicTireConstInput_PECP2 ; real_T MagicTireConstInput_PEX1 ; real_T
MagicTireConstInput_PEX2 ; real_T MagicTireConstInput_PEX3 ; real_T
MagicTireConstInput_PEX4 ; real_T MagicTireConstInput_PEY1 ; real_T
MagicTireConstInput_PEY2 ; real_T MagicTireConstInput_PEY3 ; real_T
MagicTireConstInput_PEY4 ; real_T MagicTireConstInput_PEY5 ; real_T
MagicTireConstInput_PFZ1 ; real_T MagicTireConstInput_PHX1 ; real_T
MagicTireConstInput_PHX2 ; real_T MagicTireConstInput_PHY1 ; real_T
MagicTireConstInput_PHY2 ; real_T MagicTireConstInput_PHYP1 ; real_T
MagicTireConstInput_PHYP2 ; real_T MagicTireConstInput_PHYP3 ; real_T
MagicTireConstInput_PHYP4 ; real_T MagicTireConstInput_PKX1 ; real_T
MagicTireConstInput_PKX2 ; real_T MagicTireConstInput_PKX3 ; real_T
MagicTireConstInput_PKY1 ; real_T MagicTireConstInput_PKY2 ; real_T
MagicTireConstInput_PKY3 ; real_T MagicTireConstInput_PKY4 ; real_T
MagicTireConstInput_PKY5 ; real_T MagicTireConstInput_PKY6 ; real_T
MagicTireConstInput_PKY7 ; real_T MagicTireConstInput_PKYP1 ; real_T
MagicTireConstInput_PPMX1 ; real_T MagicTireConstInput_PPX1 ; real_T
MagicTireConstInput_PPX2 ; real_T MagicTireConstInput_PPX3 ; real_T
MagicTireConstInput_PPX4 ; real_T MagicTireConstInput_PPY1 ; real_T
MagicTireConstInput_PPY2 ; real_T MagicTireConstInput_PPY3 ; real_T
MagicTireConstInput_PPY4 ; real_T MagicTireConstInput_PPY5 ; real_T
MagicTireConstInput_PPZ1 ; real_T MagicTireConstInput_PPZ2 ; real_T
MagicTireConstInput_PVX1 ; real_T MagicTireConstInput_PVX2 ; real_T
MagicTireConstInput_PVY1 ; real_T MagicTireConstInput_PVY2 ; real_T
MagicTireConstInput_PVY3 ; real_T MagicTireConstInput_PVY4 ; real_T
MagicTireConstInput_QBRP1 ; real_T MagicTireConstInput_QBZ1 ; real_T
MagicTireConstInput_QBZ10 ; real_T MagicTireConstInput_QBZ2 ; real_T
MagicTireConstInput_QBZ3 ; real_T MagicTireConstInput_QBZ4 ; real_T
MagicTireConstInput_QBZ5 ; real_T MagicTireConstInput_QBZ6 ; real_T
MagicTireConstInput_QBZ9 ; real_T MagicTireConstInput_QCRP1 ; real_T
MagicTireConstInput_QCRP2 ; real_T MagicTireConstInput_QCZ1 ; real_T
MagicTireConstInput_QDRP1 ; real_T MagicTireConstInput_QDRP2 ; real_T
MagicTireConstInput_QDTP1 ; real_T MagicTireConstInput_QDZ1 ; real_T
MagicTireConstInput_QDZ10 ; real_T MagicTireConstInput_QDZ11 ; real_T
MagicTireConstInput_QDZ2 ; real_T MagicTireConstInput_QDZ3 ; real_T
MagicTireConstInput_QDZ4 ; real_T MagicTireConstInput_QDZ6 ; real_T
MagicTireConstInput_QDZ7 ; real_T MagicTireConstInput_QDZ8 ; real_T
MagicTireConstInput_QDZ9 ; real_T MagicTireConstInput_QEZ1 ; real_T
MagicTireConstInput_QEZ2 ; real_T MagicTireConstInput_QEZ3 ; real_T
MagicTireConstInput_QEZ4 ; real_T MagicTireConstInput_QEZ5 ; real_T
MagicTireConstInput_QHZ1 ; real_T MagicTireConstInput_QHZ2 ; real_T
MagicTireConstInput_QHZ3 ; real_T MagicTireConstInput_QHZ4 ; real_T
MagicTireConstInput_QSX1 ; real_T MagicTireConstInput_QSX10 ; real_T
MagicTireConstInput_QSX11 ; real_T MagicTireConstInput_QSX12 ; real_T
MagicTireConstInput_QSX13 ; real_T MagicTireConstInput_QSX14 ; real_T
MagicTireConstInput_QSX2 ; real_T MagicTireConstInput_QSX3 ; real_T
MagicTireConstInput_QSX4 ; real_T MagicTireConstInput_QSX5 ; real_T
MagicTireConstInput_QSX6 ; real_T MagicTireConstInput_QSX7 ; real_T
MagicTireConstInput_QSX8 ; real_T MagicTireConstInput_QSX9 ; real_T
MagicTireConstInput_QSY1 ; real_T MagicTireConstInput_QSY2 ; real_T
MagicTireConstInput_QSY3 ; real_T MagicTireConstInput_QSY4 ; real_T
MagicTireConstInput_QSY5 ; real_T MagicTireConstInput_QSY6 ; real_T
MagicTireConstInput_QSY7 ; real_T MagicTireConstInput_QSY8 ; real_T
MagicTireConstInput_Q_CAM1 ; real_T MagicTireConstInput_Q_CAM2 ; real_T
MagicTireConstInput_Q_CAM3 ; real_T MagicTireConstInput_Q_FCX ; real_T
MagicTireConstInput_Q_FCY ; real_T MagicTireConstInput_Q_FCY2 ; real_T
MagicTireConstInput_Q_FYS1 ; real_T MagicTireConstInput_Q_FYS2 ; real_T
MagicTireConstInput_Q_FYS3 ; real_T MagicTireConstInput_Q_FZ1 ; real_T
MagicTireConstInput_Q_FZ2 ; real_T MagicTireConstInput_Q_FZ3 ; real_T
MagicTireConstInput_Q_RA1 ; real_T MagicTireConstInput_Q_RA2 ; real_T
MagicTireConstInput_Q_RB1 ; real_T MagicTireConstInput_Q_RB2 ; real_T
MagicTireConstInput_Q_RE0 ; real_T MagicTireConstInput_Q_V1 ; real_T
MagicTireConstInput_Q_V2 ; real_T MagicTireConstInput_RBX1 ; real_T
MagicTireConstInput_RBX2 ; real_T MagicTireConstInput_RBX3 ; real_T
MagicTireConstInput_RBY1 ; real_T MagicTireConstInput_RBY2 ; real_T
MagicTireConstInput_RBY3 ; real_T MagicTireConstInput_RBY4 ; real_T
MagicTireConstInput_RCX1 ; real_T MagicTireConstInput_RCY1 ; real_T
MagicTireConstInput_REX1 ; real_T MagicTireConstInput_REX2 ; real_T
MagicTireConstInput_REY1 ; real_T MagicTireConstInput_REY2 ; real_T
MagicTireConstInput_RHX1 ; real_T MagicTireConstInput_RHY1 ; real_T
MagicTireConstInput_RHY2 ; real_T MagicTireConstInput_RVY1 ; real_T
MagicTireConstInput_RVY2 ; real_T MagicTireConstInput_RVY3 ; real_T
MagicTireConstInput_RVY4 ; real_T MagicTireConstInput_RVY5 ; real_T
MagicTireConstInput_RVY6 ; real_T MagicTireConstInput_SSZ1 ; real_T
MagicTireConstInput_SSZ2 ; real_T MagicTireConstInput_SSZ3 ; real_T
MagicTireConstInput_SSZ4 ; real_T MagicTireConstInput_VERTICAL_STIFFNESS ;
real_T MagicTireConstInput_vdynMF [ 279 ] ; real_T
InternalVehicleXYPlotter_extRef ; real_T InternalVehicleXYPlotter_extStats ;
real_T InternalVehicleXYPlotter_extTireF ; real_T Integrator1_IC ; real_T
Integrator1_AbsoluteTolerance ; real_T Switch_Threshold ; real_T
Backlash_InitialOutput ; real_T Switch_Threshold_jujvwwykeh ; real_T
Switch1_Threshold ; real_T Switch_Threshold_az3vcbbzxw ; real_T
Switch1_Threshold_abcoyyeui2 ; real_T Integrator_IC ; real_T
Integrator_AbsoluteTolerance ; real_T Integrator_IC_pqre0d4b11 ; real_T
Integrator_AbsoluteTolerance_cy2pnd2c5m ; real_T u_Gain [ 3 ] ; real_T
Crm_tableData [ 2 ] ; real_T Crm_bp01Data [ 2 ] ; real_T
Integrator1_IC_k5k4c2qhgr ; real_T Saturation_UpperSat ; real_T
Saturation_LowerSat ; real_T Integrator_IC_ereaclltod ; real_T
Memory1_InitialCondition ; real_T Integrator2_IC ; real_T
Integrator2_AbsoluteTolerance ; real_T UnitDelay_InitialCondition_otnmjf0q3j
[ 2 ] ; real_T Integrator1_IC_l3hid1knke ; real_T Integrator1_UpperSat ;
real_T Integrator1_LowerSat ; real_T uto1_UpperSat ; real_T uto1_LowerSat ;
real_T Integrator1_IC_nspsznejiv ; real_T Saturation_UpperSat_kmdxhgxi54 ;
real_T Saturation_LowerSat_emwy1bpgop ; real_T Integrator2_IC_b0ll4d3vcw ;
real_T Integrator2_AbsoluteTolerance_jpry0t4pb0 ; real_T
Memory_InitialCondition [ 2 ] ; real_T Integrator_IC_l55lj3ait5 ; real_T
Integrator_AbsoluteTolerance_fp10kdx3ts ; real_T
Saturation_UpperSat_ifai5qs0ii ; real_T Saturation_LowerSat_mlu5gk3ggw ;
real_T Saturation_UpperSat_neu311z5mm ; real_T Saturation_LowerSat_hjvqbqjafe
; real_T Saturation_UpperSat_mslagysw1h ; real_T
Saturation_LowerSat_btyvgbsiqq ; real_T DisallowNegativeBrakeTorque_UpperSat
; real_T DisallowNegativeBrakeTorque_LowerSat ; real_T Gain_Gain ; real_T
Saturation1_UpperSat ; real_T Saturation1_LowerSat ; real_T
Saturation_UpperSat_iu12m5pvqn ; real_T Saturation_LowerSat_n2mhmgk14l ;
real_T Saturation1_UpperSat_nca1zpqikx ; real_T
Saturation1_LowerSat_av0hu4nwnp ; real_T Saturation_UpperSat_addj3whuzg ;
real_T Saturation_LowerSat_lejok2hlrr ; real_T
Saturation1_UpperSat_ewjkrotpz3 ; real_T Saturation1_LowerSat_gu1hx53qlc ;
real_T Saturation_UpperSat_akdusr1nca ; real_T Saturation_LowerSat_mhlm1x4kgd
; real_T Integrator_IC_lba0v231io ; real_T
Integrator_AbsoluteTolerance_meusfs1eni ; real_T
Saturation1_UpperSat_pr0qfpxda4 ; real_T Saturation1_LowerSat_o5kkqlla1u ;
real_T Saturation_UpperSat_l412u2t0sf ; real_T Saturation_LowerSat_kfxufjmols
; real_T Switch_Threshold_iwmujfpe4s ; real_T Integrator_IC_h2tsckar0l ;
real_T Constant_Value_f5sizwfggl [ 12 ] ; real_T Constant_Value_oqyl4nphju [
3 ] ; real_T MotorTorque_Value ; real_T Zero_Value ; real_T One_Value ;
real_T Constant_Value_c54rembgih ; real_T Gain1_Gain ; real_T steerOut_Value
; real_T Switch3_Threshold ; real_T steerOut_Value_dsforhi52t ; real_T
Constant_Value_azwfc1rw55 ; real_T Constant_Value_lqe2vx0uu0 ; real_T
Zero_Value_nvufxvzwje ; real_T theta_Value ; real_T phi_Value ; real_T
index_Value ; real_T Zero_Value_pejk1vy3ts ; real_T Gain_Gain_avfcthoedx ;
real_T Gain1_Gain_brgbyay1mx ; real_T Gain1_Gain_b44cjdquhs ; real_T
Zero_Value_bweh1erc23 [ 4 ] ; real_T ones2_Value [ 4 ] ; real_T u_Value [ 4 ]
; real_T ones_Value [ 92 ] ; real_T vertType_Value ; real_T
Constant_Value_p33r4txk3q ; real_T Constant1_Value ; real_T
TorqueConversion1_Gain ; real_T TireRadius_Value [ 4 ] ; real_T
Constant4_Value [ 3 ] ; real_T Constant1_Value_asxmciwgbn [ 9 ] ; real_T
u_Value_fblrgwg5ds ; boolean_T One1_Value ; btuihsyghq gkgoch4i20 ;
cw4bvjax0v fujf10vfd2 ; } ; extern const char_T * RT_MEMORY_ALLOCATION_ERROR
; extern B rtB ; extern X rtX ; extern DW rtDW ; extern PrevZCX rtPrevZCX ;
extern P rtP ; extern mxArray * mr_Model_GetDWork ( ) ; extern void
mr_Model_SetDWork ( const mxArray * ssDW ) ; extern mxArray *
mr_Model_GetSimStateDisallowedBlocks ( ) ; extern const
rtwCAPI_ModelMappingStaticInfo * Model_GetCAPIStaticMap ( void ) ; extern
SimStruct * const rtS ; extern DataMapInfo * rt_dataMapInfoPtr ; extern
rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr ; void MdlOutputs ( int_T tid )
; void MdlOutputsParameterSampleTime ( int_T tid ) ; void MdlUpdate ( int_T
tid ) ; void MdlTerminate ( void ) ; void MdlInitializeSizes ( void ) ; void
MdlInitializeSampleTimes ( void ) ; SimStruct * raccel_register_model ( ssExecutionInfo * executionInfo ) ;
#endif
