import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TravelPlanListCard extends StatelessWidget {
  const TravelPlanListCard({
    super.key, this.image, this.startDate, this.endDate, this.endLocation, this.startLocation, this.onTap
  });
  final String? image;
  final String? startDate;
  final String? endDate;
  final String? startLocation;
  final String? endLocation;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                offset: Offset(0, 2), // Subtle shadow effect
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: 75, width: 75, fit: BoxFit.cover,
                  imageUrl: image ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXV5sH1zrgK7iBjYohDQgja8E3uO9ziGkAjw&s",
                  placeholder: (context, url) => Center(
                    child: Image.asset("assets/images/app_icon.png"),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                      "assets/images/app_icon.png", fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_outlined, color: Branding.colors.primaryDark, size: 18),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Location From: ",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Branding.colors.primaryDark,
                                  ),
                                ),
                                TextSpan(
                                  text: startLocation ?? "N/A",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Branding.colors.primaryDark,
                                  ),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_outlined, color: Branding.colors.primaryDark, size: 18),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Location to: ",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Branding.colors.primaryDark,
                                  ),
                                ),
                                TextSpan(
                                  text: endLocation ?? "N/A",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Branding.colors.primaryDark,
                                  ),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.calendar_month, color: Branding.colors.primaryDark, size: 18),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "$startDate to $endDate",
                            style: TextStyle(
                              fontSize: 13,
                              color: Branding.colors.primaryDark,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.keyboard_arrow_right, color: Branding.colors.primaryDark),
            ],
          ),
        )

      ),
    );
  }
}