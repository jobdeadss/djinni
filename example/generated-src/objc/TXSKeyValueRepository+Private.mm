// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from KeyValueRepository.djinni

#import "TXSKeyValueRepository+Private.h"
#import "TXSKeyValueRepository.h"
#import "DJICppWrapperCache+Private.h"
#import "DJIError.h"
#import "DJIMarshal+Private.h"
#include <exception>
#include <stdexcept>
#include <utility>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@interface TXSKeyValueRepository ()

- (id)initWithCpp:(const std::shared_ptr<::textsort::KeyValueRepository>&)cppRef;

@end

@implementation TXSKeyValueRepository {
    ::djinni::CppProxyCache::Handle<std::shared_ptr<::textsort::KeyValueRepository>> _cppRefHandle;
}

- (id)initWithCpp:(const std::shared_ptr<::textsort::KeyValueRepository>&)cppRef
{
    if (self = [super init]) {
        _cppRefHandle.assign(cppRef);
    }
    return self;
}

- (nonnull NSData *)getValue:(nonnull NSString *)key {
    try {
        auto objcpp_result_ = _cppRefHandle.get()->get_value(::djinni::String::toCpp(key));
        return ::djinni::Binary::fromCpp(objcpp_result_);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (BOOL)setValue:(nonnull NSString *)key
           value:(nonnull NSData *)value {
    try {
        auto objcpp_result_ = _cppRefHandle.get()->set_value(::djinni::String::toCpp(key),
                                                             ::djinni::Binary::toCpp(value));
        return ::djinni::Bool::fromCpp(objcpp_result_);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (BOOL)removeValue:(nonnull NSString *)key {
    try {
        auto objcpp_result_ = _cppRefHandle.get()->remove_value(::djinni::String::toCpp(key));
        return ::djinni::Bool::fromCpp(objcpp_result_);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

namespace djinni_generated {

auto KeyValueRepository::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        throw std::invalid_argument("KeyValueRepository::toCpp requires non-nil object");
    }
    return NN_CHECK_ASSERT(objc->_cppRefHandle.get());
}

auto KeyValueRepository::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return ::djinni::get_cpp_proxy<TXSKeyValueRepository>(cpp);
}

}  // namespace djinni_generated

@end
