import 'package:flutter/material.dart';

class PlayerStats {
  final String imagePath;
  final String name;
  final String position;
  final String city;
  final String streak;
  final int wins;
  final int gamesPlayed;

  PlayerStats({
    required this.imagePath,
    required this.name,
    required this.position,
    required this.city,
    required this.streak,
    required this.wins,
    required this.gamesPlayed,
  });

  double get percentage => gamesPlayed == 0 ? 0 : (wins / gamesPlayed) * 100;
}

class PlayerStatsList extends StatelessWidget {
  final List<PlayerStats> players;
  const PlayerStatsList({super.key, required this.players});

  Color _getPercentageColor(double percentage) {
    if (percentage >= 70) return Colors.green;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }

  Widget _buildPlayerImage(String imagePath) {
    final isRemote =
        imagePath.startsWith('http') || imagePath.startsWith('https');
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: isRemote
          ? Image.network(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            )
          : Image.asset(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: players.map((player) {
        final percentage = player.percentage;
        final color = _getPercentageColor(percentage);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildPlayerImage(player.imagePath),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              player.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${percentage.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: color,
                                ),
                              ),
                              Text(
                                '${player.wins}/${player.gamesPlayed}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            player.position,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            player.city,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        player.streak,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
