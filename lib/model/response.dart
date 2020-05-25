

import 'package:musicapp/model/audio.dart';

class ItunesResponse {
    final int resultCount;
    final List<Audio> results;

    ItunesResponse({this.resultCount, this.results});

    factory ItunesResponse.fromJson(Map<String, dynamic> json) {
        return ItunesResponse(
            resultCount: json['resultCount'], 
            results: json['results'] != [] ? (json['results'] as List).map((i) => Audio.fromJson(i)).toList() : [],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['resultCount'] = this.resultCount;
        if (this.results != null) {
            data['results'] = this.results.map((v) => v.toJson()).toList();
        }
        return data;
    }
}