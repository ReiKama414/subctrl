import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:subctrl/shared/widgets/ui.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("ServiceAvatar prefers bundled logo asset", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ServiceAvatar("ChatGPT", logoKey: "chatgpt", size: 40),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(Image), findsOneWidget);
    final image = tester.widget<Image>(find.byType(Image));
    expect(image.image, isA<AssetImage>());
    expect((image.image as AssetImage).assetName, "assets/logos/chatgpt.png");
  });
}
