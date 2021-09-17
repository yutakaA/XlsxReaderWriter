// BRAHyperlink.h
#import <XlsxReaderWriter/BRAOpenXmlSubElement.h>


@interface BRAHyperlink : BRAOpenXmlSubElement

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *target;

- (NSDictionary *)dictionaryRepresentation;

@end
