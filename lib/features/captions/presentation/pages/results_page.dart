import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:statusify/core/di/injection_container.dart';
import 'package:statusify/features/captions/domain/entities/caption_filters.dart';
import '../bloc/captions_bloc.dart';
import '../bloc/captions_event.dart';
import '../bloc/captions_state.dart';

class ResultsPage extends StatelessWidget {
  final CaptionFilters filters;
  const ResultsPage({super.key, required this.filters});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CaptionsBloc>()..add(CaptionsRequested(filters)),
      child: Scaffold(
        appBar: AppBar(title: const Text("Results")),
        body: BlocBuilder<CaptionsBloc, CaptionsState>(
          builder: (context, state) {
            if (state is CaptionsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CaptionsError) {
              return Center(child: Text(state.message));
            }
            if (state is CaptionsLoaded) {
              if (state.items.isEmpty) {
                return const Center(
                  child: Text("No captions found for this filter."),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final text = state.items[i].text;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(text, style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              OutlinedButton.icon(
                                onPressed: () async {
                                  await Clipboard.setData(
                                    ClipboardData(text: text),
                                  );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Copied")),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.copy),
                                label: const Text("Copy"),
                              ),
                              const SizedBox(width: 10),
                              OutlinedButton.icon(
                                onPressed: () => SharePlus.instance.share(
                                  ShareParams(text: text),
                                ),
                                icon: const Icon(Icons.share),
                                label: const Text("Share"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
