#import "RootViewController.h"
#import "PulseBridge.h"

@interface RootViewController ()
@property (nonatomic, strong) UITextView *terminalView;
@property (nonatomic, strong) NSMutableString *terminalText;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Безопасный цвет фона (похож на systemGroupedBackgroundColor)
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.96 alpha:1.0];
    
    // 1. Заголовок Pulse
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Pulse";
    titleLabel.font = [UIFont systemFontOfSize:40 weight:UIFontWeightBlack];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];
    
    // 2. Текст версий
    UILabel *versionLabel = [[UILabel alloc] init];
    versionLabel.text = @"ios 15.0-17.3.1\na12-13 ios 15.0-18.7.1/26.0.1\nmade by leiJan, Eure";
    versionLabel.numberOfLines = 0;
    versionLabel.textAlignment = NSTextAlignmentRight;
    versionLabel.font = [UIFont boldSystemFontOfSize:10];
    versionLabel.textColor = [UIColor grayColor]; // Безопасный цвет
    versionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:versionLabel];
    
    // 3. Черный терминал
    UIView *terminalContainer = [[UIView alloc] init];
    terminalContainer.backgroundColor = [UIColor blackColor];
    terminalContainer.layer.cornerRadius = 10;
    terminalContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:terminalContainer];
    
    self.terminalText = [NSMutableString stringWithString:@"[*] Pulse initialized.\n[+] libjailbreak loaded.\n[!] Jailbreak status: NO\npulse> start\n"];
    self.terminalView = [[UITextView alloc] init];
    self.terminalView.backgroundColor = [UIColor clearColor];
    self.terminalView.textColor = [UIColor greenColor];
    self.terminalView.font = [UIFont fontWithName:@"Menlo" size:14];
    self.terminalView.text = self.terminalText;
    self.terminalView.editable = NO;
    self.terminalView.translatesAutoresizingMaskIntoConstraints = NO;
    [terminalContainer addSubview:self.terminalView];
    
    // 4. Список путей
    UITextView *pathsView = [[UITextView alloc] init];
    pathsView.backgroundColor = [UIColor clearColor];
    pathsView.textColor = [UIColor blackColor]; // Безопасный цвет
    pathsView.font = [UIFont fontWithName:@"Menlo" size:14];
    pathsView.text = @"/var\n/private\n/usr/libexec\n/usr/bin\n/usr/sbin\n/bin\n/sbin\n/libexec\n/private/preboot\n/SpringBoard";
    pathsView.editable = NO;
    pathsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:pathsView];
    
    // 5. Кнопка запуска
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startButton setTitle:@"START EXPLOIT" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont fontWithName:@"Menlo-Bold" size:16];
    startButton.backgroundColor = [UIColor blackColor];
    startButton.layer.cornerRadius = 10;
    [startButton addTarget:self action:@selector(startJailbreak) forControlEvents:UIControlEventTouchUpInside];
    startButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:startButton];
    
    // --- Констрейнты (Auto Layout) ---
    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
    
    [NSLayoutConstraint activateConstraints:@[
        // Заголовок
        [titleLabel.topAnchor constraintEqualToAnchor:safeArea.topAnchor constant:20],
        [titleLabel.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:20],
        
        // Версии
        [versionLabel.topAnchor constraintEqualToAnchor:safeArea.topAnchor constant:20],
        [versionLabel.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-20],
        
        // Терминал
        [terminalContainer.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:20],
        [terminalContainer.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:20],
        [terminalContainer.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-20],
        [terminalContainer.heightAnchor constraintEqualToConstant:250],
        
        [self.terminalView.topAnchor constraintEqualToAnchor:terminalContainer.topAnchor constant:10],
        [self.terminalView.bottomAnchor constraintEqualToAnchor:terminalContainer.bottomAnchor constant:-10],
        [self.terminalView.leadingAnchor constraintEqualToAnchor:terminalContainer.leadingAnchor constant:10],
        [self.terminalView.trailingAnchor constraintEqualToAnchor:terminalContainer.trailingAnchor constant:-10],
        
        // Пути
        [pathsView.topAnchor constraintEqualToAnchor:terminalContainer.bottomAnchor constant:20],
        [pathsView.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:20],
        [pathsView.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-20],
        [pathsView.bottomAnchor constraintEqualToAnchor:startButton.topAnchor constant:-20],
        
        // Кнопка
        [startButton.bottomAnchor constraintEqualToAnchor:safeArea.bottomAnchor constant:-20],
        [startButton.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:20],
        [startButton.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-20],
        [startButton.heightAnchor constraintEqualToConstant:50]
    ]];
}

- (void)startJailbreak {
    [self.terminalText appendString:@"\n[*] Running jbctl trustcache info...\n"];
    
    // Вызов нашей заглушки из PulseBridge
    int result = [PulseBridge runExploit];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (result == 0) {
            [self.terminalText appendString:@"[+] Exploit mock returned success.\n"];
            [self.terminalText appendString:[NSString stringWithFormat:@"[*] Status: %@\n", [PulseBridge getStatus]]];
        } else {
            [self.terminalText appendString:@"[!] posix_spawn failed (error: 1)\n[!] Likely Sandbox restriction (needs root).\n"];
        }
        [self.terminalText appendString:@"pulse> "];
        self.terminalView.text = self.terminalText;
        
        // Автоскролл вниз
        NSRange range = NSMakeRange(self.terminalView.text.length - 1, 1);
        [self.terminalView scrollRangeToVisible:range];
    });
}

@end
