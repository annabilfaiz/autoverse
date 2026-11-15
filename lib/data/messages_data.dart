import 'models/conversation_model.dart';
import 'models/message_model.dart';
import 'marketplace_data.dart';

class MessagesData {
  MessagesData._();

  static List<ConversationModel> getInitialConversations() {
    final now = DateTime.now();
    final allProducts = MarketplaceData.getInitialProducts();
    final akrapovicProduct = allProducts.firstWhere((p) => p.id == 'prod_01');

    return [
      // 1. Kevin Mahendra — Parts Seller (with Marketplace Product Context)
      ConversationModel(
        id: 'conv_kevin_autoparts',
        participantName: 'Kevin Mahendra',
        participantUsername: '@ak_parts_jkt',
        participantRole: 'AK Parts Jakarta • Verified Seller',
        participantAvatar: null,
        unreadCount: 2,
        productContext: akrapovicProduct,
        updatedAt: now.subtract(const Duration(minutes: 12)),
        messages: [
          MessageModel(
            id: 'm_k1',
            senderId: '@aditya_gt3',
            senderName: 'Aditya Pratama',
            text: 'Halo bro Kevin, Akrapovič Evolution Line buat 992 GT3 ready stock di Jakarta?',
            timestamp: now.subtract(const Duration(hours: 3)),
            isMe: true,
          ),
          MessageModel(
            id: 'm_k2',
            senderId: '@ak_parts_jkt',
            senderName: 'Kevin Mahendra',
            text: 'Halo bro Aditya! Ready 1 set brand new in box di workshop Pluit. Lengkap sama carbon end tips & wireless valve controller kit.',
            timestamp: now.subtract(const Duration(hours: 2, minutes: 45)),
            isMe: false,
          ),
          MessageModel(
            id: 'm_k3',
            senderId: '@aditya_gt3',
            senderName: 'Aditya Pratama',
            text: 'Mantap. Kalau fitting sekalian di tempat bisa ya? Berapa lama pengerjaannya?',
            timestamp: now.subtract(const Duration(hours: 1, minutes: 20)),
            isMe: true,
          ),
          MessageModel(
            id: 'm_k4',
            senderId: '@ak_parts_jkt',
            senderName: 'Kevin Mahendra',
            text: 'Bisa banget bro! Estimasi pasang sekitar 3-4 jam karena harus bongkar rear diffuser & setting actuator kabel vakumnya.',
            timestamp: now.subtract(const Duration(minutes: 15)),
            isMe: false,
          ),
          MessageModel(
            id: 'm_k5',
            senderId: '@ak_parts_jkt',
            senderName: 'Kevin Mahendra',
            text: 'Gimana bro, mau saya keep dulu unitnya buat mobil lo?',
            timestamp: now.subtract(const Duration(minutes: 12)),
            isMe: false,
          ),
        ],
      ),

      // 2. Daniel Wijaya — Porsche Enthusiast
      ConversationModel(
        id: 'conv_daniel_992',
        participantName: 'Daniel Wijaya',
        participantUsername: '@daniel_992',
        participantRole: 'Porsche Club Indonesia • GT3 992.1',
        participantAvatar: null,
        unreadCount: 0,
        updatedAt: now.subtract(const Duration(hours: 1, minutes: 5)),
        messages: [
          MessageModel(
            id: 'm_d1',
            senderId: '@daniel_992',
            senderName: 'Daniel Wijaya',
            text: 'Dit, video Sentul lap kemarin gokil! Catatan waktu 1:39.8 clean banget.',
            timestamp: now.subtract(const Duration(hours: 5)),
            isMe: false,
          ),
          MessageModel(
            id: 'm_d2',
            senderId: '@aditya_gt3',
            senderName: 'Aditya Pratama',
            text: 'Thanks Dan! Itu setelah ganti ke Michelin Cup 2R dan stel camber depan ke -2.8 derajat.',
            timestamp: now.subtract(const Duration(hours: 4)),
            isMe: true,
          ),
          MessageModel(
            id: 'm_d3',
            senderId: '@daniel_992',
            senderName: 'Daniel Wijaya',
            text: 'Wah pantesan grip di Turn 3-4 nempel parah. Next weekend track day bareng lagi yuk ke Sentul!',
            timestamp: now.subtract(const Duration(hours: 1, minutes: 5)),
            isMe: false,
          ),
        ],
      ),

      // 3. Adrian Kusuma — Performance Workshop Owner
      ConversationModel(
        id: 'conv_adrian_tuning',
        participantName: 'Adrian Kusuma',
        participantUsername: '@adrian_tuning',
        participantRole: 'Apex Garage • Dyno & ECU Specialist',
        participantAvatar: null,
        unreadCount: 1,
        updatedAt: now.subtract(const Duration(hours: 4)),
        messages: [
          MessageModel(
            id: 'm_a1',
            senderId: '@aditya_gt3',
            senderName: 'Aditya Pratama',
            text: 'Om Adrian, jadwal dyno tune hari Sabtu jam 10 pagi masih available?',
            timestamp: now.subtract(const Duration(hours: 6)),
            isMe: true,
          ),
          MessageModel(
            id: 'm_a2',
            senderId: '@adrian_tuning',
            senderName: 'Adrian Kusuma',
            text: 'Aman bro Dit. Slot Sabtu jam 10:00 sudah di-lock buat GT3 lo. Kita remap high octane RON 98 ya.',
            timestamp: now.subtract(const Duration(hours: 4)),
            isMe: false,
          ),
        ],
      ),

      // 4. Rafael Putra — JDM Enthusiast
      ConversationModel(
        id: 'conv_rafael_fd3s',
        participantName: 'Rafael Putra',
        participantUsername: '@rafael_fd3s',
        participantRole: 'Rotary Syndicate • RX-7 FD3S',
        participantAvatar: null,
        unreadCount: 0,
        updatedAt: now.subtract(const Duration(days: 1)),
        messages: [
          MessageModel(
            id: 'm_r1',
            senderId: '@rafael_fd3s',
            senderName: 'Rafael Putra',
            text: 'Bro Aditya, kemarin liat reel lo di trackday. Suara flat six-nya gahar abis!',
            timestamp: now.subtract(const Duration(days: 2)),
            isMe: false,
          ),
          MessageModel(
            id: 'm_r2',
            senderId: '@aditya_gt3',
            senderName: 'Aditya Pratama',
            text: 'Halo Raf! Thanks bro. RX-7 lo gimana progress bridge port-nya? Udah naik dyno?',
            timestamp: now.subtract(const Duration(days: 1, hours: 10)),
            isMe: true,
          ),
          MessageModel(
            id: 'm_r3',
            senderId: '@rafael_fd3s',
            senderName: 'Rafael Putra',
            text: 'Udah selesai break-in! Dapat 420 whp di 1.1 bar boost. Kapan-kapan meet up di BSD yuk.',
            timestamp: now.subtract(const Duration(days: 1)),
            isMe: false,
          ),
        ],
      ),
    ];
  }
}
