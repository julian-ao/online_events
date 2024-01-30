import 'package:flutter/material.dart';

import '/core/models/attendee_info_model.dart';
import '/core/models/event_model.dart';
import '/pages/event/cards/event_card.dart';
import '/pages/event/cards/event_card_buttons.dart';
import '/pages/event/cards/event_card_countdown.dart';
import '/pages/event/cards/event_participants.dart';
import '/theme/theme.dart';
import 'card_badge.dart';
import 'registration_info.dart';

class RegistrationCard extends StatelessWidget {
  static const horizontalPadding = EdgeInsets.symmetric(horizontal: 24);

  final EventModel model;
  final AttendeeInfoModel attendeeInfoModel;
  final VoidCallback onUnregisterSuccess;

  const RegistrationCard({
    super.key,
    required this.model,
    required this.attendeeInfoModel,
    required this.onUnregisterSuccess,
  });

  Widget header(int statusCode) {
    String badgeText;
    Color color;

    switch (statusCode) {
      case 502:
        badgeText = 'Stengt';
        color = OnlineTheme.red;
        break;
      case 404:
        badgeText = 'Påmeldt';
        color = OnlineTheme.green;
        break;
      case 200 || 201 || 210 || 211 || 212 || 213:
        badgeText = 'Åpen';
        color = OnlineTheme.green;
        break;
      case 420 || 421 || 422 || 423 || 401 || 402:
        badgeText = 'Utsatt';
        color = OnlineTheme.yellow;
        break;
      case 411 || 410 || 412 || 413 || 400 || 400 || 403 || 405:
        badgeText = 'Umulig';
        color = OnlineTheme.red;
        break;
      default:
        badgeText = 'Ikke Åpen';
        color = OnlineTheme.red;
    }

    return SizedBox(
      height: 32,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Påmelding',
            style: OnlineTheme.header(),
          ),
          CardBadge(
            text: badgeText,
            fill: color.withOpacity(0.4),
            border: color,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnlineCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // if (loggedIn || attendeeInfoModel.isEligibleForSignup.statusCode == 6969)
          header(attendeeInfoModel.isEligibleForSignup.statusCode),
          if (attendeeInfoModel.isEligibleForSignup.statusCode != 6969) const SizedBox(height: 16),
          if (attendeeInfoModel.isEligibleForSignup.statusCode != 6969)
            EventParticipants(
              model: model,
              attendeeInfoModel: attendeeInfoModel,
            ),
          const SizedBox(height: 16),
          if (attendeeInfoModel.isEligibleForSignup.statusCode != 6969)
            RegistrationInfo(
              attendeeInfoModel: attendeeInfoModel,
            ),
          const SizedBox(height: 10),
          if (attendeeInfoModel.isOnWaitlist == true)
            Center(
              child: Text(
                'Du er nummer ${attendeeInfoModel.whatPlaceIsUserOnWaitList} på venteliste',
                style: OnlineTheme.textStyle(),
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          EventCardButtons(
            model: model,
            attendeeInfoModel: attendeeInfoModel,
            onUnregisterSuccess: onUnregisterSuccess,
          ),
        ],
      ),
    );
  }
}
