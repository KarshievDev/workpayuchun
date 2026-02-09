import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class TravelDetailsContent extends StatelessWidget {
  final TravelPlanItem? travelPlan;
  const TravelDetailsContent({super.key,this.travelPlan});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Employee", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text("Designation",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text("From Date",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text("To Date",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text("From Location",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text("To Location",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text("Amount",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text("Status",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text("Purpose",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text("Signature Date",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(": ${travelPlan?.employee?.name ?? "N/A"}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text(": ${travelPlan?.employee?.designation ?? "N/A"}",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text(": ${travelPlan?.fromDate ?? "N/A"}",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text(": ${travelPlan?.toDate ?? "N/A"}",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text(": ${travelPlan?.fromLocation ?? "N/A"}",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text(": ${travelPlan?.toLocation ?? "N/A"}",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text(": ${travelPlan?.amount ?? "N/A"}",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text(travelPlan?.status ?? "N/A",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.orange ),),
                        const SizedBox(height: 4,),
                        Text(travelPlan?.purpose ?? "N/A",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                        const SizedBox(height: 4,),
                        Text(": ${travelPlan?.signatureDate ?? "N/A"}",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Branding.colors.primaryDark ),),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5,),
              Text("Signature : ",  style: TextStyle( fontSize: 12, color: Branding.colors.primaryDark,fontWeight: FontWeight.bold),),
              const SizedBox(height: 5,),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  height: 150, width: double.infinity, fit: BoxFit.fill, imageUrl: travelPlan?.signature ?? "",
                  placeholder: (context, url) => Center(child: Image.asset("assets/images/app_icon.png"),),
                  errorWidget: (context, url, error) => Image.asset("assets/images/app_icon.png",fit: BoxFit.cover,),
                ),
              ),
              const SizedBox(height: 5,),
            ],
          ),
        ),
      ),
    );
  }
}
