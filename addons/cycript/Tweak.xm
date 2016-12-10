#import <Cycript/Cycript.h>

%ctor { 
	CYListenServer(31337); 
}
