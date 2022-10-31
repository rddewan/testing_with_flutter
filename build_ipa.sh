output="../build/ios_integ"
product="build/ios_integ/Build/Products"
dev_target="14.7"

# Pass --simulator if building for the simulator.
flutter build ios integration_test/auth_flow_test.dart --release #--simulator

pushd ios
xcodebuild -workspace Runner.xcworkspace -scheme Runner -config Flutter/Release.xcconfig -derivedDataPath $output -sdk iphoneos build-for-testing
popd

pushd $product
zip -r "ios_tests.zip" "Release-iphoneos" "Runner_iphoneos$dev_target-arm64.xctestrun"
popd

gcloud firebase test ios run --test "build/ios_integ/Build/Products/ios_tests.zip" --device model=iphone11pro,version=14.7,locale=en_US,orientation=portrait