class Stage {
    String name;
    List<Wave> waves;

    Stage({
        this.name,
        this.waves,
    });

    factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        name: json["name"],
        waves: List<Wave>.from(json["waves"].map((x) => Wave.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "waves": List<dynamic>.from(waves.map((x) => x.toJson())),
    };
}

class Wave {
    int time;
    String enemy;
    String formation;
    double unitSize;
    int units;
    int x;

    Wave({
        this.time,
        this.enemy,
        this.formation,
        this.unitSize,
        this.units,
        this.x,
    });

    factory Wave.fromJson(Map<String, dynamic> json) => Wave(
        time: json["time"],
        enemy: json["enemy"],
        formation: json["formation"],
        unitSize: json["unitSize"],
        units: json["units"],
        x: json["x"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "time": time,
        "enemy": enemy,
        "formation": formation,
        "units": units,
        "unitSize": unitSize,
        "x": x
    };
}
