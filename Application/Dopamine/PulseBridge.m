#import "PulseBridge.h"
#import "jbclient.h"

@implementation PulseBridge

+ (int)initializeJailbreak {
    // Просто возвращаем успех, так как инициализация теперь неявная
    return 0; 
}

+ (int)prepareRootfs {
    // Проверяем, сделан ли уже джейлбрейк
    if (jbclient_dopamine_is_jailbroken()) {
        return 0; // Уже джейлбрейкнуто
    }
    return 1; // Еще нет
}

+ (int)runExploit {
    // Пытаемся связаться с демоном Dopamine
    return jbclient_process_checkin();
}

+ (NSString *)getStatus {
    if (jbclient_dopamine_is_jailbroken()) {
        return @"Jailbroken (Dopamine daemon is active)";
    }
    return @"Not Jailbroken";
}

@end
