// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from Services.djinni

#import "TXSConfiguration+Private.h"
#import "TXSConfiguration.h"
#import "DJICppWrapperCache+Private.h"
#import "DJIError.h"
#import "TXSKeyValueRepository+Private.h"
#include <exception>
#include <stdexcept>
#include <utility>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@interface TXSConfiguration ()

- (id)initWithCpp:(const std::shared_ptr<::textsort::Configuration>&)cppRef;

@end

@implementation TXSConfiguration {
    ::djinni::CppProxyCache::Handle<std::shared_ptr<::textsort::Configuration>> _cppRefHandle;
}

- (id)initWithCpp:(const std::shared_ptr<::textsort::Configuration>&)cppRef
{
    if (self = [super init]) {
        _cppRefHandle.assign(cppRef);
    }
    return self;
}

- (nonnull TXSKeyValueRepository *)keyValueRepository {
    try {
        auto objcpp_result_ = _cppRefHandle.get()->key_value_repository();
        return ::djinni_generated::KeyValueRepository::fromCpp(objcpp_result_);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

namespace djinni_generated {

auto Configuration::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        throw std::invalid_argument("Configuration::toCpp requires non-nil object");
    }
    return NN_CHECK_ASSERT(objc->_cppRefHandle.get());
}

auto Configuration::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return ::djinni::get_cpp_proxy<TXSConfiguration>(cpp);
}

}  // namespace djinni_generated

@end
